

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:i_chat/api/apis.dart';
import 'package:i_chat/main.dart';
import 'package:i_chat/models/chatUse.dart';
import 'package:i_chat/screens/profile_screen.dart';


class ChatScreen extends StatefulWidget{
  final ChatUser user;
  const ChatScreen({super.key, required this.user});


  @override
  State<StatefulWidget> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen>{

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 88, 45, 210),
        body: Stack(
          children: [
            Container(
              margin: EdgeInsets.only(top: mq.height * .15),
              decoration: BoxDecoration(color: Colors.white,
              borderRadius: BorderRadius.only(topRight: Radius.circular(38),
              topLeft: Radius.circular(38)
              )
              ),
            ),
            Row(
              children: [
                SizedBox(height: 145,width: 5,),
                IconButton(onPressed: () =>Navigator.pop(context),iconSize: 35,
                    // padding: EdgeInsets.only(top: 45,left: 5),
                    icon: Icon(Icons.arrow_back_ios_new_outlined,color: Colors.white)),
                ClipRRect(
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    width: mq.height *.05,
                    height: mq.height *.05,
                    imageUrl: widget.user.image,
                    // placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => CircleAvatar(child: Icon(CupertinoIcons.person),backgroundColor: Colors.amberAccent),
                  ),
                  borderRadius: BorderRadius.circular(mq.height *.2),
                ),
                SizedBox(width: 20,),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // User Name
                    Text(widget.user.name,style: TextStyle(fontSize: 17,fontWeight: FontWeight.w500,color: Colors.white)),
                    SizedBox(height: 5),

                    // Last seen
                    Text('Online',style: TextStyle(fontSize: 13,fontWeight: FontWeight.w500,color: Colors.white)),
                  ],),

                SizedBox(width: 85,),
                IconButton(onPressed: () {},
                    iconSize: 28,
                    icon: Icon(Icons.call_sharp,color: Colors.white)),

                IconButton(onPressed: () {},
                    iconSize: 28,
                    icon: Icon(Icons.videocam_sharp,color: Colors.white)),





              ],
            ),

          ],
        ),
      ),
    );
  }
}


