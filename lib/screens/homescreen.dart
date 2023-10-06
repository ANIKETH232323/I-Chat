import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:i_chat/main.dart';
import 'package:i_chat/widgets/chat_user_card.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // app bar
      body: Stack(

        children:[
          Container(
            child:AppBar(
             //   bottom: PreferredSize(
    //   preferredSize: const Size.fromHeight(200),
    //   child: SizedBox(),
    // ),
            backgroundColor: Color.fromARGB(255, 88, 45, 210),
              leading: const Icon(CupertinoIcons.person),
              title: const Text('I Chat',style: TextStyle(color: Colors.white),),
            actions: [
              // search button
              IconButton(onPressed: (){}, icon: const Icon(Icons.search)),

              // 3dot button
              IconButton(onPressed: (){}, icon: const Icon(Icons.more_vert))
            ],
            ),
            ),
          Container(            child: Text("Message"),
          ),
          Padding(
            padding: EdgeInsets.only(top: 200),

            child: Container(

              decoration: BoxDecoration(
              borderRadius: BorderRadius.only(topRight: Radius.circular(35),topLeft: Radius.circular(35)),
              color: Colors.white
            ),
              child: Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Container(
                  child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    padding: EdgeInsets.only(top: mq.height * .02),
                    itemCount: 16,
                    itemBuilder: (context,index){
                    return chat_user_card();

    }),
                ),
              ),
            ),
          ),
        ],

      ),


      // floating action button to add user;
      // floatingActionButton: Padding(
      //   padding: const EdgeInsets.only(bottom: 30,right: 10),
      //   child: FloatingActionButton(onPressed: (){},child: const Icon(Icons.add_comment_rounded
      //   ),),
      // ),

    );
  }
}
