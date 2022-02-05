import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Configuration extends StatefulWidget {
  const Configuration({ Key? key }) : super(key: key);

  @override
  _ConfigurationState createState() => _ConfigurationState();
}

class _ConfigurationState extends State<Configuration> {
  
  final TextEditingController _controllerName = TextEditingController();
  late XFile? _profileImage;
  late String _idCurrentUser;
  String _imageUrl = '';
  bool _loading = false;

  Future<void> _getImage(String origin) async {
    XFile? image;
    ImagePicker pickerController = ImagePicker();

    switch (origin) {
      case 'camera':
        image = await pickerController.pickImage(source: ImageSource.camera);
        break;
      case 'gallery':
        image = await pickerController.pickImage(source: ImageSource.gallery);
        break;
    }

    setState(() {
      _profileImage = image;
    });

    if (_profileImage != null) {
      await _saveImage();
    }
  }

  Future<void> _saveImage() async {
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference root = storage.ref();
    Reference file = root.child('profile').child('$_idCurrentUser.jpg');

    UploadTask uploadTask = file.putFile(File(_profileImage!.path));

    uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) async {
      final int percent = ((snapshot.bytesTransferred / snapshot.totalBytes) * 100).round();
      setState(() {
        _loading = true;
      });
      if (percent >= 100) {
        await _getUrlImage(snapshot);
        setState(() {
          _loading = false;
        });
        uploadTask.pause();
      }
    });
  }

  Future<void> _getUrlImage(TaskSnapshot snapshot) async {
    String image = await snapshot.ref.getDownloadURL(); 
    setState(() {
      _imageUrl = image;
    });
    _updateUserProfilePhoto();
  }

  Future<void> _updateUserProfilePhoto() async {
    FirebaseFirestore store = FirebaseFirestore.instance;

    store.collection('users')
      .doc(_idCurrentUser)
    .update({'imageUrl': _imageUrl});
  }

  Future<void> _updateUserProfileData() async {
    FirebaseFirestore store = FirebaseFirestore.instance;

    store.collection('users')
      .doc(_idCurrentUser)
    .update({'name': _controllerName.text});
  }

  Future<void> _getUserData() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User firebaseUser = auth.currentUser!;
    
    _idCurrentUser = firebaseUser.uid;

    FirebaseFirestore store = FirebaseFirestore.instance;
    DocumentSnapshot snapshot = await store.collection('users').doc(_idCurrentUser).get();

    dynamic data = snapshot.data();
    setState(() {
      _controllerName.text = data['name'];
      if (data['imageUrl'] != null) {
        _imageUrl = data['imageUrl'];
      }
    });
  }

  @override
  void initState() {
    _getUserData();
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Configurations'
        )
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              _loading 
              ? const CircularProgressIndicator()
              : Container(), 
              CircleAvatar(
                radius: 100,
                backgroundColor: Colors.grey,
                backgroundImage: _imageUrl.isNotEmpty ? NetworkImage(_imageUrl) : null,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextButton(
                    onPressed: () async => await _getImage('camera'),
                    child: Text('Camera')
                  ),
                  TextButton(
                    onPressed: () async => await _getImage('gallery'),
                    child: Text('Gallery')
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: TextField(
                  controller: _controllerName,
                  autofocus: true,
                  keyboardType: TextInputType.text,
                  style: const TextStyle(
                    fontSize: 20
                  ),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.fromLTRB(32, 16, 32, 16),
                    hintText: 'Nome',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32)
                    )
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16, bottom: 10),
                child: ElevatedButton(
                  onPressed: _updateUserProfileData,
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color>((states) => Colors.green),
                    padding: MaterialStateProperty.resolveWith<EdgeInsets>((states) => const EdgeInsets.fromLTRB(32, 16, 32, 16)),
                    shape: MaterialStateProperty.resolveWith<RoundedRectangleBorder>((states) => RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)))
                  ),
                  child: const Text(
                    'Save',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}