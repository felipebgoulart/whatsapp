import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mob_whatsapp/core/models/chat.dart';
import 'package:mob_whatsapp/core/models/message.dart';
import 'package:mob_whatsapp/core/models/user.dart';
import 'package:mob_whatsapp/core/services/firebase_service.dart';
import 'package:mobx/mobx.dart';

part 'messages_controller.g.dart';

class MessagesController = _MessagesControllerBase with _$MessagesController;

abstract class _MessagesControllerBase with Store {

  final FirebaseService _firebaseService = FirebaseService();
  final FirebaseFirestore _store = FirebaseFirestore.instance;
  final StreamController<QuerySnapshot> streamController = StreamController<QuerySnapshot>.broadcast();
  final scrollController = ScrollController();

  _MessagesControllerBase();

  @observable
  TextEditingController controllerMessages = TextEditingController();
  
  @observable
  String? loggedUserId;

  @observable
  String? targetUserId;

  @observable
  String? loggedUserName;

  @observable
  UserModel? contact;

  @observable
  bool loading = false;

  @observable
  FocusNode messageNode = FocusNode();

  @action
  void setContact(UserModel userContact) {
    contact = userContact;
  }

  @action
  Future<void> getUserData() async {
    User firebaseUser = await _firebaseService.getFirebaseUserData();
    
    loggedUserId = firebaseUser.uid;
    targetUserId =  contact!.id!;
    UserModel user = await _firebaseService.getLoggedUserData();
    loggedUserName = user.name!;
    _chatListener();
  }

  @action
  void _chatListener() {
    final stream = _store.collection('messages')
      . doc(loggedUserId)
      .collection(targetUserId!)
      .orderBy('date', descending: false)
      .snapshots();

    stream.listen((event) {
      streamController.add(event);
    });
  }

  void sendMessage() async  {
    String message = controllerMessages.text;

    if (message.isNotEmpty) {
       MessageModel sentMessage = MessageModel(
        idUser: loggedUserId!,
        date: Timestamp.now().toString(),
        type: 'text',
        message: message,
        urlImage: ''
      );

      _saveMessage(loggedUserId!, targetUserId!, sentMessage);
      _saveMessage(targetUserId!, loggedUserId!, sentMessage);
      _saveChat(sentMessage);
    }
  }

  @action
  Future<void> _saveMessage(String idCurrentUser, String idDestinationUser, MessageModel message) async {
    controllerMessages.clear();
    await _store.collection('messages')
      .doc(idCurrentUser)
      .collection(idDestinationUser)
      .add(message.toMap()
    );
  }

  void _saveChat(MessageModel message) {
    Chat chatSender = Chat(
      idSender: loggedUserId!,
      idReceiver: targetUserId!,
      message: message.message!,
      name: loggedUserName!,
      photoPath: contact!.imageUrl!,
      type: message.type,
      dateTime: DateTime.now()
    );

    chatSender.saveChat();

    Chat chatReceiver = Chat(
      idSender: targetUserId!,
      idReceiver: loggedUserId!,
      message: message.message!,
      name: contact!.name!,
      photoPath: contact!.imageUrl!,
      type: message.type,
      dateTime: DateTime.now()
    );

    chatReceiver.saveChat();
  }

  @action
  Future<void> sendImage() async {
    ImagePicker picker = ImagePicker();
    XFile? selectedImage;
    selectedImage = await picker.pickImage(source: ImageSource.gallery);

    String imageName = DateTime.now().millisecondsSinceEpoch.toString();
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference root = storage.ref();
    Reference file = root.child('messages').child(loggedUserId!).child('$imageName.jpg');

    loading = true;

    file.putFile(File(selectedImage!.path)).then((snapshot) async => {
      if (snapshot.state == TaskState.success) {
        await _getUrlImage(snapshot),
        loading = false
      }
    });
  }

  Future<void> _getUrlImage(TaskSnapshot snapshot) async {
    String image = await snapshot.ref.getDownloadURL();

    MessageModel sentMessage = MessageModel(
      idUser: loggedUserId!,
      date: Timestamp.now().toString(),
      type: 'image',
      message: '',
      urlImage: image
    );

    _saveMessage(loggedUserId!, targetUserId!, sentMessage);
    _saveMessage(targetUserId!, loggedUserId!, sentMessage);
  }

}