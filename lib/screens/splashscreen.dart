import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:i_chat/main.dart';
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
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor:Colors.transparent));
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const Homescreen()));
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
