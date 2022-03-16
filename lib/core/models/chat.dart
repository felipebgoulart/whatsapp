import 'package:cloud_firestore/cloud_firestore.dart';

class Chat {

  String idSender;
  String idReceiver;
  String name;
  String message;
  String photoPath;
  String type;
  DateTime dateTime;

  Chat({
    required this.idSender,
    required this.idReceiver,
    required this.name,
    required this.message,
    required this.photoPath,
    required this.type,
    required this.dateTime
  });

  factory Chat.fromJson(Map<String, dynamic> json) {
    return Chat(
      idSender: json['idSender'] ?? '',
      idReceiver: json['idReceiver'] ?? '',
      name: json['name'] ?? '',
      message: json['message'] ?? '',
      photoPath: json['photoPath'] ?? '',
      type: json['type'] ?? '',
      dateTime: json['dateTime'] ?? DateTime.now()
    );
  }

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