import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:i_chat/appBar/homeScreenAppBar.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  @override
  Widget build(BuildContext context) {
    return homeScreenAppBar();
  }
}

