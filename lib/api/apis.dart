import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:http/http.dart';
import 'package:i_chat/models/Message.dart';
import 'package:i_chat/models/chatUse.dart';

class ApIs {
  static FirebaseAuth auth = FirebaseAuth.instance;
  static FirebaseStorage storage = FirebaseStorage.instance;

  // for storing self info
  static late ChatUser me;

  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  static User get user => auth.currentUser!;

  // for checking User exits or not
  static Future<bool> userExists() async {
    return (await firestore.collection('user').doc(user.uid).get()).exists;
  }

  // for checking User Self info
  static Future<void> userSelfInfo() async {
    return firestore.collection('user').doc(user.uid).get().then((user) async {
      if (user.exists) {
        me = ChatUser.fromJson(user.data()!);
        await getFirebaseMessageToken();
        ApIs.updateStatus(true);
      } else {
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

  // for getting all user  from firestore database

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllUser() {
    return firestore
        .collection('user')
        .where('id', isNotEqualTo: user.uid)
        .snapshots();
  }

  // for update name and about in firebase after changing in profile section
  static Future<void> changeNamAbout() async {
    await firestore.collection('user').doc(user.uid).update({
      'name': me.name,
      'about': me.about,
    });
  }

  // Update Profile Picture
  static Future<void> updateProfilePicture(File file) async {
    final ext = file.path.split('.').last;
    final ref = storage.ref().child('profile_picture/${user.uid}.$ext');
    await ref
        .putFile(file, SettableMetadata(contentType: 'images/$ext'))
        .then((p0) {
      log('Data Transfered: ${p0.bytesTransferred / 1000} kb');
    });

    // updating image in firestore database
    me.image = await ref.getDownloadURL();
    await firestore.collection('user').doc(user.uid).update({'image': me.name});
  }

  /// ****************  CHAT SCREEN RELATED APIS *********************

  ///  useful for getting conversation  id

  static String getConversationId(String id) => user.uid.hashCode <= id.hashCode
      ? '${user.uid}_$id'
      : '${id}_${user.uid}';

  // FOR GETTING ALL USER FROM FIRESTORE DATABASE
  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllMessages(
      ChatUser user) {
    return firestore
        .collection('chats/${getConversationId(user.id)}/messages/')
        .orderBy('sent', descending: true)
        .snapshots();
  }

  // for sending messages
  static Future<void> sendMessage(
      ChatUser ChatUser1, String message1, Type type) async {
    // message sending time(also use an id)
    final time = DateTime.now().millisecondsSinceEpoch.toString();

    // message to send
    final Message message = Message(
        told: ChatUser1.id,
        msg: message1,
        read: '',
        type: type,
        formId: user.uid,
        sent: time);

    final ref = firestore
        .collection('chats/${getConversationId(ChatUser1.id)}/messages/');
    await ref.doc(time).set(message.toJson()).then((value) =>
        sendPushNotification(ChatUser1,type == Type.text ? message1 : 'image'));
  }

  // Chats(Collection) --> Conversation Id(doc) --> messages(Collection) --> message(doc)

  // Update Read Status of message
  static Future<void> updateMessageReadStatus(Message message) async {
    firestore
        .collection('chats/${getConversationId(message.formId)}/messages/')
        .doc(message.sent)
        .update({'read': DateTime.now().millisecondsSinceEpoch.toString()});
  }

  // get Only last message show in a specific chat

  static Stream<QuerySnapshot<Map<String, dynamic>>> getLastMessages(
      ChatUser user) {
    return firestore
        .collection('chats/${getConversationId(user.id)}/messages/')
        .orderBy('sent', descending: true)
        .limit(1)
        .snapshots();
  }

  static Future<void> sendChatImage(ChatUser chatUser, File file) async {
    final ext = file.path.split('.').last;
    final ref = storage.ref().child(
        'Sending_images/${getConversationId(chatUser.id)}/${DateTime.now().millisecondsSinceEpoch}.$ext');
    await ref
        .putFile(file, SettableMetadata(contentType: 'images/$ext'))
        .then((p0) {
      log('Data Transfered: ${p0.bytesTransferred / 1000} kb');
    });

    // updating image in firestore database
    final imageUrl = await ref.getDownloadURL();
    await sendMessage(chatUser, imageUrl, Type.image);
  }

  // get user last seen or online info showing
  static Stream<QuerySnapshot<Map<String, dynamic>>> getUserStatusInfo(
      ChatUser chatUser) {
    return firestore
        .collection('user')
        .where('id', isEqualTo: chatUser.id)
        .snapshots();
  }

  static Future<void> updateStatus(bool isOnline) async {
    firestore.collection('user').doc(user.uid).update({
      'is_online': isOnline,
      'last_active': DateTime.now().millisecondsSinceEpoch.toString(),
      'push_token': me.pushToken,
    });
  }

  // FOR PUSH NOTIFICATIONS
  static FirebaseMessaging messaging = FirebaseMessaging.instance;

  // For getting Fire Base message token
  static Future<void> getFirebaseMessageToken() async {
    await messaging.requestPermission();

    messaging.getToken().then((value) {
      if (value != null) {
        me.pushToken = value;
        log("Push Token: $value");
      }
    });

    // the Comment is for checking Later remove
    // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    //   log('Got a message whilst in the foreground!');
    //   log('Message data: ${message.data}');
    //
    //   if (message.notification != null) {
    //     log('Message also contained a notification: ${message.notification}');
    //   }
    // });
  }

  static Future<void> sendPushNotification(ChatUser chatUser,String msg) async {
    try{

      final body = {
        "to":chatUser.pushToken,
        "notification":{
          "title":chatUser.name,
          "body" :msg,
          "android_channel_id" :"ChatsID"
        },
        "data": {
          "Some_Data" : "User ID: ${me.id}",
        },
      };

      var response = await post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
          headers: {
            HttpHeaders.contentTypeHeader:'application/json',
            HttpHeaders.authorizationHeader:
            "key = AAAA9b1wpkE:APA91bH5Fde27lGIAjs2jDLCedVy5SY1dvlY10Ja6bBGsYv09f-_EMhxKZqzYGBhEKZwQlpVW_jqT0BiHJgywXPdC6JeE1WAecJnhjL_PXmI8favtjlcQI9tSUnOYOdhSxEkZ9GEaDL2"
          },
          body: jsonEncode(body));
      log('Response status: ${response.statusCode}');
      log('Response body: ${response.body}');
    }
        catch(e){
      log('\nsendPushNotificationE:$e');
        }
  }
}
