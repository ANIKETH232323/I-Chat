import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:i_chat/models/chatUse.dart';

class ApIs{
  static FirebaseAuth auth = FirebaseAuth.instance;

  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  static User get user => auth.currentUser!;

  // for checking User exits or not
  static Future<bool>userExists() async {
    return (await firestore.collection('user').doc(user.uid).get())
        .exists;
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


}
