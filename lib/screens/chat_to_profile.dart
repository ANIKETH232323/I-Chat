import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:i_chat/api/apis.dart';
import 'package:i_chat/helper/dialoage.dart';
import 'package:i_chat/helper/mydate_donemark.dart';
import 'package:i_chat/main.dart';
import 'package:i_chat/models/chatUse.dart';
import 'package:i_chat/screens/auth/login_screen.dart';
import 'package:image_picker/image_picker.dart';

class ChatToProfileScreen extends StatefulWidget {
  final ChatUser user;
  const ChatToProfileScreen({super.key, required this.user});

  @override
  State<ChatToProfileScreen> createState() => _ChatToProfileScreenState();
}

class _ChatToProfileScreenState extends State<ChatToProfileScreen> {
  String? _image;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          // Back Ground Colour Blue
          Container(
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 88, 45, 210),
            ),
          ),

          // Back Ground Colour White
          Container(
            height: mq.height * .71,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(45),
                    topRight: Radius.circular(45))),
          ),

          Positioned(
            top: mq.height * .16,
            child: Column(
              children: [
                _image != null
                    ?
                // for selecting local image
                ClipRRect(
                  child: Image.file(
                    File(_image!),
                    fit: BoxFit.cover,
                    width: mq.height * .2,
                    height: mq.height * .2,
                  ),
                  borderRadius: BorderRadius.circular(mq.height * .2),
                )
                    :
                // Profile Picture from defult gmail image
                ClipRRect(
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    width: mq.height * .2,
                    height: mq.height * .2,
                    imageUrl: widget.user.image,
                    // placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => CircleAvatar(
                        child: Icon(CupertinoIcons.person),
                        backgroundColor: Colors.amberAccent),
                  ),
                  borderRadius: BorderRadius.circular(mq.height * .2),
                ),
                SizedBox(
                  height: mq.height * .03,
                ),

                // Non Editable Text
                Material(
                  type: MaterialType.transparency,
                  child: Column(
                    children: [
                      Container(
                        child: Text(widget.user.name,
                        style: TextStyle(color: Colors.black,fontSize: 25,fontWeight: FontWeight.bold,),

                        ),
                      ),
                      SizedBox(height: 20,),
                      Row(children: [
                        Container(child: Text("About: ",style: TextStyle(fontWeight: FontWeight.w900
                        ,fontSize: 18
                        ),)),
                        Container(
                          child: Text(widget.user.about,
                            style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.w700,),

                          ),
                        ),
                      ],)
                    ],
                  ),
                ),

                SizedBox(height: mq.height * .45,),
                //Joined Date
                Material(
                    type: MaterialType.transparency,
                    child: Row(
                      children: [
                        Text("Joined: ",style: TextStyle(fontSize:19,fontWeight: FontWeight.w900 )),
                    Text(MyDate.getLastMessageTime(context: context, sent1: widget.user.createdAt,showYear: true),
                      style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.w700,))
                      ],
                    ))


              ],
            ),
            
          ),
        ],
        
      ),
    );
  }

}
