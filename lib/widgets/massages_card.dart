import 'package:flutter/material.dart';
import 'package:i_chat/api/apis.dart';
import 'package:i_chat/main.dart';
import 'package:i_chat/models/Message.dart';

class MessageCard extends StatefulWidget{

  const MessageCard({super.key, required this.message});

  final Message message;

  @override
  State<MessageCard> createState()=> _MessageCardState();

}

class _MessageCardState extends State<MessageCard> {
  @override
  Widget build(BuildContext context) {
    return ApIs.user.uid == widget.message.formId
        ? _greenMessage()
        : _blueMessage();
  }


  // sender or another user message

  Widget _blueMessage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 24),
          child: Flexible(
            child: Container(

              padding: EdgeInsets.all(15),
              margin: EdgeInsets.only(top: 30,left: 25),
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 151, 71, 255),
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30),bottomRight: Radius.circular(30),)
              ),
              child: Text(widget.message.msg+" dfniewniadsvsdjknvjkdsjkvdfvdsvskjnvjkrengjkeoewnfinfiueeo",

                style:TextStyle(color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),

        // For Time
        Container(
            margin: EdgeInsets.symmetric(horizontal: 29,vertical: 5),
            child: Text("12.00 AM",
              style: TextStyle(fontSize: 12,fontWeight: FontWeight.w600),
            ))
      ],
    );
  }

  // our or user message
  Widget _greenMessage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 24),
          child: Container(
            padding: EdgeInsets.all(15),
            width: 125,
            margin: EdgeInsets.only(top: 30,left: 25),
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 151, 71, 255),
                borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30),bottomLeft: Radius.circular(30),)
            ),
            child: Text(widget.message.msg,
              style:TextStyle(color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),

        // For Time
        Container(
            margin: EdgeInsets.symmetric(horizontal: 29,vertical: 5),
            child: Text("12.00 AM",
              style: TextStyle(fontSize: 12,fontWeight: FontWeight.w600),
            ))
      ],
    );
  }

}


