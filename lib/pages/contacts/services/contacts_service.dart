import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mob_whatsapp/core/models/user.dart';
import 'package:mob_whatsapp/core/services/firebase_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ContactsService {
  
  final FirebaseService _firebaseService = FirebaseService();

  ContactsService();

  Future<List<UserModel>> findContacts() async {
    try {
      FirebaseFirestore store = FirebaseFirestore.instance;
      User firebaseUser = await _firebaseService.getFirebaseUserData();

      QuerySnapshot querySnapshot = await store.collection('users').get();
      List<UserModel> userList = [];

      for (DocumentSnapshot item in querySnapshot.docs) {
        dynamic data = item.data();

        if (item.id == firebaseUser.uid) continue;

        UserModel user = UserModel.fromJson(data);
        user.id = item.id;

        userList.add(user);
      }

      return userList;
    } catch (error) {
      throw Exception();
    }
  }
}