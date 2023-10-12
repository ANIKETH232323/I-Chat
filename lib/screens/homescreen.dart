import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:i_chat/api/apis.dart';
import 'package:i_chat/main.dart';
import 'package:i_chat/models/chatUse.dart';
import 'package:i_chat/screens/profile_screen.dart';
import 'package:i_chat/widgets/chat_user_card.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});






  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  List<ChatUser> list = [];


  @override
  void initState() {
    super.initState();
    ApIs.userSelfInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 88, 45, 210),
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  alignment: Alignment.bottomLeft,
                  padding: EdgeInsets.only(left: mq.height * .045,top: mq.height * .045),
                  child: IconButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(
                        builder: (_)=>ProfileScreen(user: ApIs.me)));
                  },
                    icon: new Image.asset("images/acc.png"),),
                ),

                // CachedNetworkImage(
                //   fit: BoxFit.cover,
                //   width: mq.height *.02,
                //   height: mq.height *.01,
                //   imageUrl: widget.chatUser.image,
                //   // placeholder: (context, url) => CircularProgressIndicator(),
                //   errorWidget: (context, url, error) => CircleAvatar(child: Icon(CupertinoIcons.person),backgroundColor: Colors.amberAccent),
                // ),
                SizedBox(height: mq.height * .015,),
                searchBox(),
                Flexible(
                  fit: FlexFit.tight,
                  child: Container(
                    decoration: BoxDecoration(color: Colors.white,
                      borderRadius: BorderRadius.only(topRight: Radius.circular(25),topLeft: Radius.circular(25))
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: StreamBuilder(
                        stream: ApIs.getAllUser(),
                        builder: (context, snapshot) {
                          switch (snapshot.connectionState) {
                          // if Data is loading
                            case ConnectionState.waiting:
                            case ConnectionState.none:
                              return const Center(child: CircularProgressIndicator());
                          // if some or all data is loaded then show it
                            case ConnectionState.active:
                            case ConnectionState.done:
                              final data = snapshot.data?.docs;
                              list = data
                                  ?.map((e) => ChatUser.fromJson(e.data()))
                                  .toList() ??
                                  [];
                          }
                          if(list.isNotEmpty){
                            return ListView.builder(
                                physics: BouncingScrollPhysics(),
                                itemCount: list.length,
                                itemBuilder: (context, index) {
                                  return chat_user_card(user: list[index],);
                                  // return Text('Name:${list[index]}');
                                });
                          }
                          else{
                            return Center(child: Text('No Connection Found',style: TextStyle(fontSize: 18),));
                          }
                        },
                      ),
                    ),
                  ),
                )


              ],
            )
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 18.0),
            //   child: Column(
            //     children: [
            //       _HeaderSection(),
            //       searchBox(),
            //     ],
            //   ),
            // ),




          ],
        ),
      ),
    );
  }
}

class searchBox extends StatelessWidget {
  const searchBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: EdgeInsets.all( mq.height * .019),
      child: Container(
        height: mq.height *.05,
        padding: EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          color: Colors.white60,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Flexible(
                    child: SizedBox(
                  height: mq.height *.05,
                  child: TextField(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(bottom: 5),
                      hintText: "Search Message Here",
                      border: InputBorder.none,
                    ),
                  ),
                )),
                Icon(
                  Icons.search,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class _HeaderSection extends StatelessWidget {
  const _HeaderSection();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(
                  builder: (_)=>ProfileScreen(user: ApIs.me)));
              },
              icon: new Image.asset("images/acc.png"),)
            // Custom_Navigation_Button(
            //   icon: Icon(Icons.menu_rounded),
            // )
          ],
        ),
      ],
    );
  }
}
