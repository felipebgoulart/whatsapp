import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mob_whatsapp/core/models/chat.dart';
import 'package:mob_whatsapp/core/models/user.dart';
import 'package:mob_whatsapp/core/services/firebase_service.dart';
import 'package:mob_whatsapp/routes/routes.dart';
import 'package:mobx/mobx.dart';
part 'chats_controller.g.dart';

class ChatsController = _ChatsControllerBase with _$ChatsController;

abstract class _ChatsControllerBase with Store {

  final FirebaseService _firebaseService = FirebaseService();
  final StreamController<QuerySnapshot> controller = StreamController<QuerySnapshot>.broadcast();

  _ChatsControllerBase();

  @observable
  List<Chat> chatList = ObservableList.of([]);

  void snapshotToChat(QuerySnapshot? querySnapshot) {
    chatList.clear();
    List<DocumentSnapshot> chats = querySnapshot!.docs.toList();
    
    for (dynamic element in chats) {
      String chatJson = json.encode(element.data());
      chatList.add(
        Chat.fromJson(json.decode(chatJson))
      );
    }
  }

  Future<void> chatListener() async {
    final FirebaseFirestore db = FirebaseFirestore.instance;

    User user = await _firebaseService.getFirebaseUserData();

    final stream = db.collection('chats')
      .doc(user.uid)
      .collection('last_chat')
      .snapshots();

    stream.listen((event) {
      controller.add(event);
    });
  }

  void goToChat(BuildContext context, Chat chat) {
    UserModel user = UserModel(
      email: '',
      id: chat.idSender,
      imageUrl: chat.photoPath,
      name: chat.name,
    );

    Navigator.pushNamed(
      context,
      Routes.messages,
      arguments: user
    );
  }
}