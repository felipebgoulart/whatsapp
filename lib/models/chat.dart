import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Chat {

  String idSender;
  String idReceiver;
  String name;
  String message;
  String photoPath;
  String type;

  Chat({
    required this.idSender,
    required this.idReceiver,
    required this.name,
    required this.message,
    required this.photoPath,
    required this.type
  });

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'idSender': idSender,
      'idReceiver': idReceiver,
      'name': name,
      'message': message,
      'photoPath': photoPath,
      'type': type
    };

    return map;
  }

  Future<void> saveChat() async {
    FirebaseFirestore storage = FirebaseFirestore.instance;
    storage.collection('chats')
      .doc(idReceiver)
      .collection('last_chat')
      .doc(idSender)
      .set( toMap());
  }
}