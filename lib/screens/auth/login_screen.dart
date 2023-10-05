import 'package:flutter/material.dart';
import 'package:i_chat/main.dart';
import 'package:i_chat/screens/homescreen.dart';

class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  bool _isAnimate = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(milliseconds: 100),(){
      setState(() {
        _isAnimate = true;
      });
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
          AnimatedPositioned(
              top: mq.height * .25,
              right: _isAnimate? mq.width * .35 : -mq.width * .55,
              width: mq.width * .25,

              duration: const Duration(seconds: 1),
              child: Image.asset('images/icon.png')),



          // Google Login

          Positioned(
              top: mq.height * .65,
              width: mq.width * .75,
              left: mq.width * .12,
              height: mq.height * .07,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green ,
                  shape: const StadiumBorder()
                ),
                  onPressed: (){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const Homescreen()));
                  },
                  icon:Image.asset('images/icon.png',height: mq.height * .05) ,
                  label: RichText(
                    text: const TextSpan(
                      style: TextStyle(color: Colors.black,fontSize: 15,),
                      children: [
                        TextSpan(text: "Log In With "),
                        TextSpan(text: "Google",
                          style: TextStyle(fontWeight: FontWeight.bold)
                        )
                      ]
                    ),
                  )
              )
          )
        ],
      ),
      // floating action button to add user;
    );
  }
}
