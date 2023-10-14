import 'dart:io';
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:i_chat/api/apis.dart';
import 'package:i_chat/helper/dialoage.dart';
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
    super.initState();
    Future.delayed(const Duration(milliseconds: 100),(){
      setState(() {
        _isAnimate = true;
      });
    });
  }

  handleGoogleButtonClick(){

    // for showing progress bar
    Dialogs.showProgressBar(context);
      _signInWithGoogle().then((user) async {
        // for hiding progress bar
        Navigator.pop(context);
        if(user != null){

          if((await ApIs.userExists())){
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (_) => const Homescreen()));
          }

          else{
            await ApIs.createUser().then((value) {
              Navigator.pushReplacement(context,MaterialPageRoute(builder: (_)=> const Homescreen()));
            });
          }

        }


      });
  }

  Future<UserCredential?> _signInWithGoogle() async {
    try{
      await InternetAddress.lookup('google.com');
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      return await ApIs.auth.signInWithCredential(credential);
    }
    catch(e){
      // log(' \n_signInWithGoogle: $e' as num);
      Dialogs.showSnackBar(context, 'Something Went wrong Check Your Internet connection');
      return null;
    }
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
                    handleGoogleButtonClick();
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
