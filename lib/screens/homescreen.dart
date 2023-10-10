import 'package:flutter/material.dart';
import 'package:i_chat/api/apis.dart';
import 'package:i_chat/appBar/homeScreenAppBar.dart';
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 88, 45, 210),
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            Card(
              margin: EdgeInsets.only(top: 158),
              shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.only(topLeft: Radius.circular(25))),
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: StreamBuilder(
                  stream: ApIs.firestore.collection('user').snapshots(),
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Column(
                children: [
                  _HeaderSection(),
                  searchBox(),
                ],
              ),
            ),
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
    return Container(
      margin: EdgeInsets.only(top: 55),
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
                height: 40,
                child: TextField(
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(bottom: 10),
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
    );
  }
}

class _HeaderSection extends StatelessWidget {
  const _HeaderSection();
  @override
  Widget build(BuildContext context) {
    List<ChatUser>list = [];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (_)=>ProfileScreen()));}, icon: new Image.asset("images/acc.png"),)
            // Custom_Navigation_Button(
            //   icon: Icon(Icons.menu_rounded),
            // )
          ],
        ),
      ],
    );
  }
}
