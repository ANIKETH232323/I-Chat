import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:i_chat/main.dart';
import 'package:i_chat/widgets/chat_user_card.dart';

class homeScreenAppBar extends StatelessWidget {
  const homeScreenAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("I Chat"),

      ),
    );
  }
}
