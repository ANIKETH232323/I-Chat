

import 'package:flutter/material.dart';
import 'package:i_chat/models/chatUse.dart';

class ChatScreen extends StatefulWidget{
  final ChatUser user;
  const ChatScreen({super.key, required this.user});

  @override
  State<StatefulWidget> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen>{
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}

