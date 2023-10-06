import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:i_chat/main.dart';

class chat_user_card extends StatefulWidget{
  const chat_user_card({super.key});


  @override
  State<chat_user_card> createState() => _chatUser();
}

class _chatUser extends State<chat_user_card> {
  @override
  Widget build(BuildContext context) {

    return Card(
      margin: EdgeInsets.symmetric(horizontal: mq.width * .04, vertical: 4),
      child: InkWell(
          onTap: (){},
          child: ListTile(
            leading: CircleAvatar(child: Icon(CupertinoIcons.person),),
            title: Text('Demo User'),
            subtitle: Text('Last User Name',maxLines: 1,),
            trailing: Text('12.00 PM',style: TextStyle(fontWeight:FontWeight.bold),),
          )),
    );
  }

}