import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_notification_channel/flutter_notification_channel.dart';
import 'package:flutter_notification_channel/notification_importance.dart';
import 'package:flutter_notification_channel/notification_visibility.dart';
import 'package:i_chat/models/chatUse.dart';
import 'package:i_chat/screens/auth/login_screen.dart';
import 'firebase_options.dart';


// Future<void> backGroundHandeler(RemoteMessage message) async{
//     String? title = message.notification!.title;
//     String? body = message.notification!.body;
//     AwesomeNotifications().createNotification(content: NotificationContent(id: 123, channelKey: "Call_channel",
//     title: title,
//       body: body,
//         category: NotificationCategory.Call,
//       wakeUpScreen: true,
//       fullScreenIntent: true,
//       autoDismissible: false,
//
//     ),
//     actionButtons: [
//       NotificationActionButton(key: "Accept", label: "Accept Call",autoDismissible: true,color: Colors.blue),
//       NotificationActionButton(key: "Decline", label: "Decline Call",autoDismissible: true,color: Colors.red),
//         ]
//
//     );
//
//   }


late Size mq;
Future main() async {
  await dotenv.load(fileName: ".env");
  // AwesomeNotifications().initialize(null, [
  //   NotificationChannel(channelKey: "Call_channel", channelName: "Call Channel", channelDescription: "Calling",
  //     channelShowBadge: true,
  //     locked: true,
  //
  //   )
  // ]);
  // FirebaseMessaging.onBackgroundMessage((message) => backGroundHandeler(message));
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp,DeviceOrientation.portraitDown]).then((value){
    _initialFirebase();

    runApp(const MyApp());
  });

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.



  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'I Chat',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.black),
          titleTextStyle: TextStyle(color: Colors.black,
              fontWeight:FontWeight.bold,
              fontSize: 25
          ),
          backgroundColor: Colors.white,
        ),
      ),
      home: const Loginscreen()
    );
  }
}

_initialFirebase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,);
  var result = await FlutterNotificationChannel.registerNotificationChannel(
    description: 'For Showing Message Notifications',
    id: 'ChatsID',
    importance: NotificationImportance.IMPORTANCE_HIGH,
    name: 'CHATS',
    visibility: NotificationVisibility.VISIBILITY_PUBLIC,
    allowBubbles: true,
    enableVibration: true,
    enableSound: true,
    showBadge: true,
  );
  
}
