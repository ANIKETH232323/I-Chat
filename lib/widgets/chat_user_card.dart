import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:i_chat/main.dart';
import 'package:i_chat/models/chatUse.dart';

class chat_user_card extends StatefulWidget{

  final ChatUser  user;


  const chat_user_card({super.key, required this.user});


  @override
  State<chat_user_card> createState() => _chatUser();
}

class _chatUser extends State<chat_user_card> {

  @override
  Widget build(BuildContext context) {

    return Card(
      margin: EdgeInsets.symmetric(horizontal: mq.width * .04, vertical: 4),
      elevation: 1,
      child: InkWell(
          onTap: (){},
          child: ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(mq.height *.3),
              child: CachedNetworkImage(
                width: mq.height *.055,
                height: mq.height *.055,
                imageUrl: widget.user.image,
                // placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => CircleAvatar(child: Icon(CupertinoIcons.person),backgroundColor: Colors.amberAccent),
              ),
            ),
            title: Text(widget.user.name),
            subtitle: Text(widget.user.about,maxLines: 1,),
            trailing: Container(
              width: 25,height: 25,
              decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(20)
              ),
            )
            // trailing: Text('12.00 PM',style: TextStyle(fontWeight:FontWeight.bold),),
          )),
    );
  }

}