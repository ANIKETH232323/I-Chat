import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:i_chat/api/apis.dart';
import 'package:i_chat/main.dart';
import 'package:i_chat/screens/auth/login_screen.dart';
import 'package:i_chat/screens/homescreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(milliseconds: 150),(){
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(systemNavigationBarColor: Colors.white));


      if(ApIs.auth != null){

        log('\n user: ${ApIs.auth.currentUser}');

        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const Homescreen()));
      }
      else{
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const Loginscreen()));
      }
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const Loginscreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return Scaffold(
      // app bar
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Welcome to I Chat',style: TextStyle(fontSize: 20)),
      ),
      body: Stack(
        children: [
          Positioned(
              top: mq.height * .25,
              right:  mq.width * .35,
              width: mq.width * .25,
              child: Image.asset('images/icon.png')),



          // Google Login

          Positioned(
              top: mq.height * .65,
              width: mq.width * .75,
              left: mq.width * .12,
              height: mq.height * .07,
              child: const Text("Made In India With ❤️ Flutter",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),)

          )
        ],
      ),
      // floating action button to add user;
    );
  }
}
