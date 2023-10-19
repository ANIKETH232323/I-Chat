import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:i_chat/main.dart';

import 'package:i_chat/models/chatUse.dart';
import 'package:i_chat/screens/chat_to_profile.dart';

class ProfileDialoge extends StatelessWidget {
  final ChatUser user;
  const ProfileDialoge({super.key, required this.user});


  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white.withOpacity(1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      content: SizedBox(
        width: mq.width * .6,
        height: mq.height * .3,
        child: Stack(children: [
          Text(user.name,style: TextStyle(fontWeight: FontWeight.w600,fontSize: 20)),
          Align(
            alignment: Alignment.center,
            child: ClipRRect(
              child: CachedNetworkImage(
                fit: BoxFit.cover,
                width: mq.height * .2,
                height: mq.height * .2,
                imageUrl: user.image,
                // placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => CircleAvatar(
                    child: Icon(CupertinoIcons.person),
                    backgroundColor: Colors.amberAccent),
              ),
              borderRadius: BorderRadius.circular(mq.height * .2),
            ),
          ),
          Positioned(
            bottom: 230,
            left: 210,
            child: Align(
              alignment: Alignment.topRight,
                child: MaterialButton(
                  minWidth: 0,
                  padding: EdgeInsets.all(0),
                  shape: CircleBorder(),
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.push(context, MaterialPageRoute(builder: (_) => ChatToProfileScreen(user: user),));
                  },
                    child: Icon(Icons.info_outline_rounded))),
          )
        ]),


      ),
    );
  }
}
