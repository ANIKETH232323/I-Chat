

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:i_chat/main.dart';
import 'package:i_chat/models/chatUse.dart';


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
        backgroundColor: Color.fromARGB(255, 88, 45, 209),
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

            // Status Bar or CALL OR VIDEO BAR
            Row(
              children: [
                SizedBox(height: mq.height * .15,width: mq.width * .02,),
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
                SizedBox(width: mq.width * .035,),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // User Name
                    Text(widget.user.name,style: TextStyle(fontSize: 17,fontWeight: FontWeight.w500,color: Colors.white)),
                    SizedBox(height: mq.height * .005),

                    // Last seen
                    Text('Online',style: TextStyle(fontSize: 13,fontWeight: FontWeight.w500,color: Colors.white)),
                  ],),

                SizedBox(width: mq.height * .09,),
                IconButton(onPressed: () {},
                    iconSize: 28,
                    icon: Icon(Icons.call_sharp,color: Colors.white)),

                IconButton(onPressed: () {},
                    iconSize: 28,
                    icon: Icon(Icons.videocam_sharp,color: Colors.white)),
              ],
            ),

            //CHATS AND SENDING BUTTONS

            Column(children: [
              SizedBox(height: 125,),
              Expanded(
                child: StreamBuilder(
                  // stream: ApIs.getAllUser(),
                  stream: null,
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                    // if Data is loading
                      case ConnectionState.waiting:
                      case ConnectionState.none:
                        // return const Center(
                        //     child: CircularProgressIndicator());
                    // if some or all data is loaded then show it
                      case ConnectionState.active:
                      case ConnectionState.done:
                        // final data = snapshot.data?.docs;
                        // _list = data
                        //     ?.map((e) => ChatUser.fromJson(e.data()))
                        //     .toList() ??
                        //     [];
                        final _list = [];
                        if (_list.isNotEmpty) {
                          return ListView.builder(
                              physics: BouncingScrollPhysics(),
                              itemCount:_list.length,
                              itemBuilder: (context, index) {
                                return Text('Message:${_list[index]}');
                              });
                        } else {
                          return Center(
                              child: Text(
                                'Say Hii! 👋',
                                style: TextStyle(fontSize: 25),
                              ));
                        }
                    }
                  },
                ),
              ),

              SizedBox(
                height: 90,
                  child: Expanded(child: _chatInput())),

            ],)
          ],

        ),

      ),
    );

  }
  Widget _chatInput(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          Expanded(
            child: Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              child: Row(children: [

                // emoji Button
                IconButton(onPressed: (){}, icon: Icon(Icons.emoji_emotions_rounded,size: 20,),),

                Expanded(
                    child: TextField(
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      decoration: InputDecoration(
                          hintText: "Message",
                          hintStyle: TextStyle(fontWeight: FontWeight.bold),
                          border: InputBorder.none
                      ),
                    )),

                // Pick Up
                IconButton(onPressed: (){}, icon: Icon(Icons.image,size: 20,)),

                // Camera Button
                IconButton(onPressed: (){}, icon: Icon(Icons.camera_alt,size: 20,)),
              ],),
            ),
          ),
          SizedBox(height: 500,),
          MaterialButton(onPressed: (){},
            shape: CircleBorder(),
              minWidth: 0,
              padding: EdgeInsets.only(left: 15,top: 10,bottom: 10,right: 10),
              color: Color.fromARGB(255, 10, 10, 115),
            child: Transform.rotate(
              angle: -.8,
              child: Icon(Icons.send_rounded,size: 35,
                color:Colors.white),
            )),
        ],
      ),
    );
  }
}


