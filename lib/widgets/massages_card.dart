import 'package:flutter/material.dart';
import 'package:i_chat/api/apis.dart';
import 'package:i_chat/helper/mydate_donemark.dart';
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
  Widget _greenMessage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 24),
          child: Flexible(
            child: Container(
              padding: EdgeInsets.all(15),
              margin: EdgeInsets.only(top: mq.height * .04),
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 151, 71, 255),
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30),bottomLeft: Radius.circular(30),)
              ),
              child: Text(widget.message.msg,
                style:TextStyle(color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),

        // For Time and SEEN
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [

            // double check Icon for message Check

            if(widget.message.read.isNotEmpty)
              Container(

                margin: EdgeInsets.only(top: mq.height * .005),
                child: Icon(Icons.done_all_rounded,color: Colors.blue)),


            // Sent Time
            Container(
                margin: EdgeInsets.only(left: mq.width * .02,right: mq.width * .065,top: mq.height * .005),
                child: Text(MyDate.getFormattedTime(context: context, time: widget.message.sent),
                  style: TextStyle(fontSize: 12,fontWeight: FontWeight.w600),
                )),

          ],)
      ],
    );
  }
  Widget _blueMessage() {

    // update blue tick done mark
    if(widget.message.read.isEmpty){
      ApIs.updateMessageReadStatus(widget.message);
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 24),
          child: Flexible(
            child: Container(
              padding: EdgeInsets.all(15),
              margin: EdgeInsets.only(top: mq.height * .01,left: mq.width * .05),
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 197, 197, 195),
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30),bottomRight: Radius.circular(30),)
              ),
              child: Text(widget.message.msg,

                style:TextStyle(color: Color.fromARGB(255, 67, 56, 56),
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
        // For Time and Double right Button
        Row(children: [
          Container(
              margin: EdgeInsets.only(top:mq.height * .008,left: mq.height * .03),
              child: Icon(Icons.done_all_rounded,color: Colors.blue)),
          Container(
              margin: EdgeInsets.only(left:mq.width * .02,top: mq.height * .008),
              child: Text(MyDate.getFormattedTime(context: context, time: widget.message.sent),
                style: TextStyle(fontSize: 12,fontWeight: FontWeight.w600),
              )),

        ],)
      ],
    );
  }

  // our or user message


}


