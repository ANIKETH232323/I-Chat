import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:i_chat/api/apis.dart';
import 'package:i_chat/helper/mydate_donemark.dart';
import 'package:i_chat/main.dart';
import 'package:i_chat/models/Message.dart';
import 'package:i_chat/models/chatUse.dart';
import 'package:i_chat/screens/ChatScreen.dart';

class chat_user_card extends StatefulWidget{

  final ChatUser  user;


  const chat_user_card({super.key, required this.user});


  @override
  State<chat_user_card> createState() => _chatUser();
}

class _chatUser extends State<chat_user_card> {

  // last message info  if null --> no message
  Message ? _message;
  @override
  Widget build(BuildContext context) {

    return Card(
      margin: EdgeInsets.symmetric(horizontal: mq.width * .04, vertical: 4),
      elevation: 1,
      child: InkWell(
          onTap: (){
            // from navigating to chat Screen
            Navigator.push(context, MaterialPageRoute(builder: (_)=> ChatScreen(user: widget.user,)));
          },
          child: StreamBuilder(
              stream: ApIs.getLastMessages(widget.user),
              builder: (context, snapshot) {
                final data = snapshot.data?.docs;

                final list = data
                    ?.map((e) => Message.fromJson(e.data()))
                    .toList() ??
                    [];
                if(list.isNotEmpty){
                  _message = list[0];

                }
                return ListTile(
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
                    subtitle: Text(_message !=null ?
                    _message!.type == Type.image ?
                        'Photo':
                    _message!.msg : widget.user.about,maxLines: 1,),
                    trailing: _message == null ? null :
                    _message!.read.isEmpty && _message!.formId !=ApIs.user.uid ?

                    Container(
                      width: 25,height: 25,
                      decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          borderRadius: BorderRadius.circular(20)
                      ),
                    ) : Text(MyDate.getLastMessageTime(context: context,sent: _message!.sent))
                  // trailing: Text('12.00 PM',style: TextStyle(fontWeight:FontWeight.bold),),
                );
              } ,)),
    );
  }

}