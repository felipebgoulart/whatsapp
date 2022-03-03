import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:mob_whatsapp/models/chat.dart';

class Chats extends StatefulWidget {
  const Chats({ Key? key }) : super(key: key);

  @override
  _ChatsState createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {
  final _controller = StreamController<QuerySnapshot>.broadcast();
  final FirebaseFirestore db = FirebaseFirestore.instance;
  late String _idCurrentUser;

  Future<String> _getDownloadUri(String name) async {
    Reference ref = FirebaseStorage.instance.refFromURL(name);
    String url = await ref.getDownloadURL();

    return url;
  }

  void _chatListener() {
    final stream = db.collection('chats')
      .doc(_idCurrentUser)
      .collection('last_chat')
      .snapshots();

    stream.listen((event) {
      _controller.add(event);
    });
  }

  Future<void> _getUserData() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User firebaseUser = auth.currentUser!;
    
    _idCurrentUser = firebaseUser.uid;
    _chatListener();
  }

  @override
  void initState() {
    super.initState();
    _getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _controller.stream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot?> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return Center(
              child: Column(
                children: const <Widget>[
                  Text('Carregando conversas  '),
                  CircularProgressIndicator()
                ],
              ),
            );
          case ConnectionState.active:
          case ConnectionState.done:
            if (snapshot.hasError) {
              return const Text('Erro ao carregar dados');
            } else {
              QuerySnapshot? querySnapshot = snapshot.data;
              
              if (querySnapshot!.docs.isEmpty) {
                return const Center(
                  child: Text(
                    'Você não tem nenhuma mensagem ainda',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                );
              }

              return ListView.builder(
                itemCount: querySnapshot.docs.length,
                itemBuilder: (BuildContext context, int index) {
                  List<DocumentSnapshot> chats = querySnapshot.docs.toList();
                  DocumentSnapshot item = chats[index];

                  String photoPath = item['photoPath'];
                  String name = item['name'];
                  String message = item['message'];
                  String type = item['type'];

                  return ListTile(
                    contentPadding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                    leading: FutureBuilder(
                      future: _getDownloadUri(photoPath),
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
                      name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16
                      ),
                    ),
                    subtitle: Text(
                      type == 'text' ? message : '',
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
      },
    );
  }
}