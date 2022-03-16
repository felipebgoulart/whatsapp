import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mob_whatsapp/core/models/user.dart';

class FirebaseService {

  FirebaseService();

  Future<User> getFirebaseUserData() async {
    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      User firebaseUser = auth.currentUser!;
      
      return firebaseUser; 
    } catch (error) {
      throw FirebaseException(plugin: 'error get current user data: $error');
    }
  }

  Future<UserModel> getLoggedUserData() async {
    try {
      FirebaseFirestore store = FirebaseFirestore.instance;
      FirebaseAuth auth = FirebaseAuth.instance;
      User firebaseUser = auth.currentUser!;

      DocumentSnapshot snapshot = await store.collection('users')
        .doc(firebaseUser.uid)
        .get();

      dynamic decoded = snapshot.data();

      return UserModel.fromJson(decoded);
    } catch (error) {
      throw FirebaseException(plugin: 'error get logged user collection data: $error');
    }
  }

  Future<UserModel> getUserDataById(String uuid) async {
    try {
      FirebaseFirestore store = FirebaseFirestore.instance;

      DocumentSnapshot snapshot = await store.collection('users')
        .doc(uuid)
        .get();

      dynamic decoded = snapshot.data();

      return UserModel.fromJson(decoded);
    } catch (error) {
      throw FirebaseException(plugin: 'error get target user collection data: $error');
    }
  }  

  Future<void> updateProfilePicture(String userId, XFile? image) async {
    try {
      FirebaseStorage storage = FirebaseStorage.instance;
      Reference root = storage.ref();
      Reference file = root.child('profile').child('$userId.jpg');

      UploadTask uploadTask = file.putFile(File(image!.path));

      uploadTask.whenComplete(() async {
        String imageUrl = await uploadTask.snapshot.ref.getDownloadURL();
        FirebaseFirestore store = FirebaseFirestore.instance;

        store.collection('users')
          .doc(userId)
        .update({'imageUrl': imageUrl});

        uploadTask.pause();
      });
    } catch (error) {
      throw FirebaseException(plugin: 'error upload image: $error');
    }
  }

  Future<void> saveUser(UserModel user, String firebaseUserId) async {
    try {
      FirebaseFirestore db = FirebaseFirestore.instance;
      db.collection('users')
        .doc(firebaseUserId)
      .set(user.toMap());
    } catch(error) {
      throw FirebaseException(plugin: 'error save user collection: $error');
    }
  }
}