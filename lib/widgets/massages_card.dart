
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:i_chat/api/apis.dart';
import 'package:i_chat/helper/dialoage.dart';
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
    bool isMe = ApIs.user.uid == widget.message.formId;
    return InkWell(
      onLongPress: (){
        _showBottomSheetForMessage(isMe);
      },
      child: isMe ? _greenMessage() : _blueMessage(),);

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
              child:
              widget.message.type == Type.text ?
              Text(widget.message.msg,
                style:TextStyle(color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ): ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  width: mq.width * .65,
                  imageUrl: widget.message.msg,
                  placeholder: (context, url) => CircularProgressIndicator(),
                  // placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(Icons.image,size: 70,),
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

    // update blue  tick done mark
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
              child:
                  widget.message.type == Type.text ?
              Text(widget.message.msg,

                style:TextStyle(color: Color.fromARGB(255, 67, 56, 56),
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ) : ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                child: CachedNetworkImage(
                      fit: BoxFit.cover,

                      imageUrl: widget.message.msg,
                      // placeholder: (context, url) => CircularProgressIndicator(),
                      errorWidget: (context, url, error) => Icon(Icons.image,size: 70,),
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

  // buttom sheet

  void _showBottomSheetForMessage(bool isMe) {
    showModalBottomSheet(
        context: context,
        showDragHandle: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25), topRight: Radius.circular(25))),
        builder: (_) {
          return ListView(
            shrinkWrap: true,
            children: [
              widget.message.type == Type.text ?
              _OptionItem(icon: Icon(Icons.copy,color: Colors.blueAccent,),
                  name: 'Copy Text',
                  onTap: ()  async {
                if(mounted){
                   await Clipboard.setData(
                      ClipboardData(text: widget.message.msg))
                      .then((value) {
                    //for hiding bottom sheet
                    Navigator.pop(context);

                  });
                   Dialogs.showSnackBarSuccessful(context, 'Successful');
                }

                  })
              :
              _OptionItem(icon: Icon(Icons.download_for_offline,color: Colors.blueAccent,),
                  name: 'Save Image',
                  onTap: () async {
                try{
                  await GallerySaver.saveImage(widget.message.msg,albumName: 'I CHATS').then((success) {
                    Navigator.pop(context);
                    if(success != null && success)
                      Dialogs.showSnackBarSuccessful(context, "Downloaded");

                  });
                }
                catch(e){
                  log('Error while saving image: $e');
                }
                  }),


              SizedBox(
                height: mq.height * .02,
              ),
              if(widget.message.type == Type.text && isMe)
              _OptionItem(icon: Icon(Icons.edit,color: Colors.blueAccent,),
                  name: 'Edit Text',
                  onTap: (){
                Navigator.pop(context);
                _showMessageUpdateDialog();

                  }),
              if(isMe)
              Divider(color: Colors.black26,indent: 17,endIndent: 17),
              if(isMe)
              SizedBox(
                height: mq.height * .02,
              ),
              if(isMe)
              _OptionItem(icon: Icon(Icons.delete,color: Colors.red,),
                  name: 'Delete Text',
                  onTap: () async {

                await ApIs.deleteMessage(widget.message).then((value){
                  Navigator.pop(context);
                });
                  }),
              Divider(color: Colors.black26,indent: 17,endIndent: 17),
              SizedBox(
                height: mq.height * .02,
              ),
              _OptionItem(icon: Icon(Icons.remove_red_eye,color: Colors.green,),
                  name: 'Seen At: ${MyDate.getLastSeenReadTime(context: context, time:  widget.message.sent)}',
                  onTap: (){
                  }),
              SizedBox(
                height: mq.height * .02,
              ),
              _OptionItem(icon: Icon(Icons.remove_red_eye_sharp,color: Colors.red,),
                  name:widget.message.read.isEmpty? "Read At: Not Seen Yet":
                  'Read At: ${MyDate.getLastSeenReadTime(context: context, time: widget.message.sent)}',
                  onTap: (){

                  }),
              SizedBox(
                height: mq.height * .03,
              ),

            ],
          );
        });
  }
  void _showMessageUpdateDialog() {
    String updatedMsg = widget.message.msg;

    showDialog(
        context: context,
        builder: (_) => AlertDialog(
          contentPadding: const EdgeInsets.only(
              left: 24, right: 24, top: 20, bottom: 10),

          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20)),

          //title
          title: Row(
            children: const [
              Icon(
                Icons.message,
                color: Colors.blue,
                size: 28,
              ),
              Text(' Update Message')
            ],
          ),

          //content
          content: TextFormField(
            initialValue: updatedMsg,
            maxLines: null,
            onChanged: (value) => updatedMsg = value,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15))),
          ),

          //actions
          actions: [
            //cancel button
            MaterialButton(
                onPressed: () {
                  //hide alert dialog
                  Navigator.pop(context);
                },
                child: const Text(
                  'Cancel',
                  style: TextStyle(color: Colors.blue, fontSize: 16),
                )),

            //update button
            MaterialButton(
                onPressed: () {
                  //hide alert dialog
                  Navigator.pop(context);
                  ApIs.UpdateMessage(widget.message, updatedMsg);
                },
                child: const Text(
                  'Update',
                  style: TextStyle(color: Colors.blue, fontSize: 16),
                ))
          ],
        ));
  }

}

class _OptionItem extends StatelessWidget{

  final Icon icon;
  final String name;
  final VoidCallback onTap;
const _OptionItem({required this.icon, required this.name, required this.onTap});


  @override
  Widget build(BuildContext context) {
   return InkWell(
     onTap: () => onTap,
     child: Padding(
       padding: EdgeInsets.symmetric(horizontal: 25,vertical: 15),
       child: Row(
         children: [
            icon,
           Text("  $name",style: TextStyle(fontSize: 18,letterSpacing: .5),)
         ],
       ),
     ),
   );
  }}



//dialog for updating message content



