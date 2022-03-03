import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mob_whatsapp/models/chat.dart';
import 'package:mob_whatsapp/models/message.dart';
import 'package:mob_whatsapp/models/user.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Messages extends StatefulWidget {
  final UserModel contact;

  const Messages({
    Key? key,
    required this.contact
  }) : super(key: key);

  @override
  _MessagesState createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  final TextEditingController _controllerMessages = TextEditingController();
  late  String _idCurrentUser;
  late  String _idDstinationUser;
  FirebaseFirestore db = FirebaseFirestore.instance;
  late XFile _image;
  bool _loading = false;

  void _sendImage() async {
    ImagePicker picker = ImagePicker();
    XFile? selectedImage;
    selectedImage = await picker.pickImage(source: ImageSource.gallery);

    String imageName = DateTime.now().millisecondsSinceEpoch.toString();
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference root = storage.ref();
    Reference file = root.child('messages').child(_idCurrentUser).child('$imageName.jpg');

    _loading = true;

    file.putFile(File(selectedImage!.path)).then((snapshot) async => {
      if (snapshot.state == TaskState.success) {
        await _getUrlImage(snapshot),
        setState(() {
          _loading = false;
        })
      }
    });
  }

  Future<void> _getUrlImage(TaskSnapshot snapshot) async {
    String image = await snapshot.ref.getDownloadURL();

    MessageModel sentMessage = MessageModel(
      idUser: _idCurrentUser,
      type: 'image',
      message: '',
      urlImage: image
    );

    _saveMessage(_idCurrentUser, _idDstinationUser, sentMessage);
    _saveMessage(_idDstinationUser, _idCurrentUser, sentMessage);
  }

  void _sendMessage() async  {
    String message = _controllerMessages.text;

    if (message.isNotEmpty) {
       MessageModel sentMessage = MessageModel(
        idUser: _idCurrentUser,
        type: 'text',
        message: message,
        urlImage: ''
      );

      _saveMessage(_idCurrentUser, _idDstinationUser, sentMessage);
      _saveMessage(_idDstinationUser, _idCurrentUser, sentMessage);
      _saveChat(sentMessage);
    }
  }

  void _saveChat(MessageModel message) {
    Chat chatSender = Chat(
      idSender: _idCurrentUser,
      idReceiver: _idDstinationUser,
      message: message.message!,
      name: widget.contact.name!,
      photoPath: widget.contact.imageUrl!,
      type: message.type
    );

    chatSender.saveChat();

    Chat chatReceiver = Chat(
      idSender: _idDstinationUser,
      idReceiver: _idCurrentUser,
      message: message.message!,
      name: widget.contact.name!,
      photoPath: widget.contact.imageUrl!,
      type: message.type
    );

    chatReceiver.saveChat();
  }

  void _saveMessage(String idCurrentUser, String idDestinationUser, MessageModel message) async {
    await db.collection('messages')
      .doc(idCurrentUser)
      .collection(idDestinationUser)
      .add(message.toMap()
    );
    _controllerMessages.clear();
  }

  Future<void> _getUserData() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User firebaseUser = auth.currentUser!;
    
    _idCurrentUser = firebaseUser.uid;
    _idDstinationUser =  widget.contact.id!;
  } 

  Widget _stream() => StreamBuilder(
    stream: db.collection('messages')
      . doc(_idCurrentUser)
      .collection(_idDstinationUser).snapshots(),
    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
      switch (snapshot.connectionState) {
        case ConnectionState.none:
        case ConnectionState.waiting:
          return Center(
            child: Column(
              children: const <Widget>[
                Text('Carregando mensagens'),
                CircularProgressIndicator()
              ],
            ),
          );
        case ConnectionState.active:
        case ConnectionState.done:
          QuerySnapshot? querySnapshot = snapshot.data;

          if (snapshot.hasError) {
            return const Text('Erro ao carregar dados');
          } else {
            return Expanded(
              child: ListView.builder(
                itemCount: querySnapshot!.docs.length,
                itemBuilder: (BuildContext context, int index) {

                  List<DocumentSnapshot> messages = querySnapshot.docs.toList();
                  DocumentSnapshot item =  messages[index];

                  Color messageColor = const Color(0xffd2ffa5);
                  Alignment alignment = Alignment.centerRight;
                  double maxWidth = MediaQuery.of(context).size.width * .8;

                  if (_idCurrentUser != item['idUser']) {
                    alignment = Alignment.centerLeft;
                    messageColor = Colors.white;
                  }

                  return Align(
                    alignment: alignment,
                    child: Padding(
                      padding: const EdgeInsets.all(6),
                      child: Container(
                        width: maxWidth,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: messageColor,
                          borderRadius: const BorderRadius.all(Radius.circular(8))
                        ),
                        child: item['type'] == 'text'
                        ? Text(
                            item['message'],
                            style: const TextStyle(
                              fontSize: 18
                            ),
                          )
                        : Image.network(item['urlImage'])
                      ),
                    ),
                  );
                }
              )
            );
          }
       }
    },
  );

  Widget _messageBox() => Container(
    padding: const EdgeInsets.all(8),
    child: Row(
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: 8),
            child: TextField(
              controller: _controllerMessages,
              autofocus: true,
              keyboardType: TextInputType.text,
              style: const TextStyle(
                fontSize: 20
              ),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                hintText: 'Mensagem',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(32)
                ),
                suffixIcon: IconButton(
                  onPressed: _sendImage,
                  icon: const Icon(Icons.camera_alt),
                )
              ),
            ),
          )
        ),
        FloatingActionButton(
          onPressed: () => _sendMessage() ,
          backgroundColor: Theme.of(context).primaryColor,
          child: const Icon(
            Icons.send,
            color: Colors.white,
          ),
          mini: true,
        )
      ],
    ),
  );

  @override
  void initState() {
    super.initState();
    _getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: <Widget>[
            CircleAvatar(
              maxRadius: 20,
              backgroundColor: Colors.grey,
              backgroundImage: NetworkImage(widget.contact.imageUrl ?? ''),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                widget.contact.name ?? '',
              ),
            )
          ],
        )
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/bg.png'),
            fit: BoxFit.cover
          )
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: <Widget>[
                _stream(),
                _messageBox()
              ],
            ),
          )
        ),
      ),
    );
  }
}