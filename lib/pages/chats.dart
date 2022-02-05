import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:mob_whatsapp/models/chat.dart';

class Chats extends StatefulWidget {
  const Chats({ Key? key }) : super(key: key);

  @override
  _ChatsState createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {
  List<Chat> chatList = [
    Chat(
      name: 'Maria Alice',
      message: 'Miss u :(',
      photoPath: 'gs://mob-whatsapp.appspot.com/profile/perfil1.jpg'
    ),
    Chat(
      name: 'Pedro Silva',
      message: 'Can u talk now?',
      photoPath: 'gs://mob-whatsapp.appspot.com/profile/perfil2.jpg'
    ),
    Chat(
      name: 'Ana Clara',
      message: 'Hello, how r u?',
      photoPath: 'gs://mob-whatsapp.appspot.com/profile/perfil3.jpg'
    ),
    Chat(
      name: 'Gustavo',
      message: 'Hello friend!',
      photoPath: 'gs://mob-whatsapp.appspot.com/profile/perfil4.jpg'
    ),
    Chat(
      name: 'Jamilton Damasceno',
      message: 'Hello friend!',
      photoPath: 'gs://mob-whatsapp.appspot.com/profile/perfil5.jpg'
    ),
  ];

  Future<String> _getDownloadUri(String name) async {
    Reference ref = FirebaseStorage.instance.refFromURL(name);
    String url = await ref.getDownloadURL();

    return url;
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: chatList.length,
      itemBuilder: (BuildContext context, int index) {
        Chat chat = chatList[index];

        return ListTile(
          contentPadding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
          leading: FutureBuilder(
            future: _getDownloadUri(chat.photoPath),
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
            chat.name,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16
            ),
          ),
          subtitle: Text(
            chat.message,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 14
            ),
          ),
        );
      }
    );
  }
}