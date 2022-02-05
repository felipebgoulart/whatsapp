import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:mob_whatsapp/models/user.dart';
import 'package:mob_whatsapp/routes/routes.dart';

class Contacts extends StatefulWidget {
  const Contacts({ Key? key }) : super(key: key);

  @override
  _ContactsState createState() => _ContactsState();
}

class _ContactsState extends State<Contacts> {
  
  late String _idCurrentUser;
  late String _currentEmail;
  
  Future<void> _getUserData() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User firebaseUser = auth.currentUser!;
    
    _idCurrentUser = firebaseUser.uid;
    _currentEmail = firebaseUser.email!;
    
  }

  Future<List<UserModel>> _getContacts() async {
    FirebaseFirestore store = FirebaseFirestore.instance;

    QuerySnapshot querySnapshot = await store.collection('users').get();
    List<UserModel> userList = [];

    for (DocumentSnapshot item in querySnapshot.docs) {
      dynamic data = item.data();

      if (data['email'] == _currentEmail) continue;

      UserModel user = UserModel(
        name: data['name'],
        email: data['email'],
        imageUrl: data['imageUrl']
      );

      userList.add(user);
    }

    return userList;
  }

  Future<String> _getDownloadUri(String name) async {
    Reference ref = FirebaseStorage.instance.refFromURL(name);
    String url = await ref.getDownloadURL();

    return url;
  }

  @override
  void initState() {
    super.initState();
    _getUserData();
  }
  
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getContacts(),
      builder: (BuildContext context, AsyncSnapshot<List<UserModel>> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return Center(
              child: Column(
                children: const <Widget>[
                  Text('Carregando contatos'),
                  CircularProgressIndicator()
                ],
              ),
            );
          case ConnectionState.active:
          case ConnectionState.done:
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index) {
                List<UserModel>? userList = snapshot.data;
                UserModel user = userList![index];
          
                return ListTile(
                  onTap: () => {
                    Navigator.pushNamed(
                      context,
                      Routes.messages,
                      arguments: user
                    )
                  },
                  contentPadding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                  leading: FutureBuilder(
                    future: _getDownloadUri(user.imageUrl ?? ''),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        return CircleAvatar(
                          maxRadius: 30,
                          backgroundColor: Colors.grey,
                          backgroundImage: NetworkImage(snapshot.data),
                        );
                      } else {
                        return const CircleAvatar(
                          maxRadius: 30,
                          backgroundColor: Colors.grey,
                        );
                      }
                    }
                  ),
                  title: Text(
                    user.name ?? '',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16
                    ),
                  )
                );
              }
            );
        }
      },
    );
  }
}