import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:i_chat/calling_VideoCalling/constignoregit.dart';
import 'package:i_chat/models/chatUse.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class Mycall extends StatelessWidget {
  const Mycall({super.key, required this.callID, required this.userID, required this.userName});
  final String callID;
  final String userID;
  final String userName;

  @override
  Widget build(BuildContext context) {


    return ZegoUIKitPrebuiltCall(
      appID: Myconst.APP_ID,
      appSign: Myconst.APP_SIGNINID,
      userID: userID,
      userName: userName,
      callID: callID,
      // You can also use groupVideo/groupVoice/oneOnOneVoice to make more types of calls.
      config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall()
        ..onOnlySelfInRoom = (context) => Navigator.of(context).pop(),
    );
  }
}
