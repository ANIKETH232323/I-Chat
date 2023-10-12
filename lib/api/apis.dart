import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:i_chat/models/chatUse.dart';

class ApIs{
  static FirebaseAuth auth = FirebaseAuth.instance;

  // for storing self info
  static late ChatUser me;

  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  static User get user => auth.currentUser!;

  // for checking User exits or not
  static Future<bool>userExists() async {
    return (await firestore.collection('user').doc(user.uid).get())
        .exists;
  }

  // for checking User Self info
  static Future<void>userSelfInfo() async {
    return firestore.collection('user').doc(user.uid).
    get().then((user) async {
      if(user.exists){
        me =ChatUser.fromJson(user.data()!);
      }
      else{
        await createUser().then((value) => userSelfInfo());
      }
    });
  }




  // for creating new User

  static Future<void> createUser() async {
    final time = DateTime.now().millisecondsSinceEpoch.toString();

    final chatUser = ChatUser(
        id: user.uid,
        name: user.displayName.toString(),
        email: user.email.toString(),
        about: "Hey, I'm using We Chat!",
        image: user.photoURL.toString(),
        createdAt: time,
        isOnline: false,
        lastActive: time,
        pushToken: '');

    return await firestore
        .collection('user')
        .doc(user.uid)
        .set(chatUser.toJson());
  }

    static Stream<QuerySnapshot<Map<String, dynamic>>> getAllUser(){
      return firestore.collection('user').where('id',isNotEqualTo: user.uid).snapshots();
    }

  // for update name and about in firebase after changing in profile section
  static Future<void>changeNamAbout() async {
    await firestore.collection('user').doc(user.uid).update({
      'name':me.name,
      'about':me.about,
    });
  }


}
