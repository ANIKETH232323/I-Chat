import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:i_chat/main.dart';
import 'package:i_chat/widgets/chat_user_card.dart';

class homeScreenAppBar extends StatelessWidget{
  const homeScreenAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 88, 45, 210)
            ),
            child: AppBar(
              backgroundColor:Color.fromARGB(255, 88, 45, 210),
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
          Container(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 700,
              decoration:BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(40),
                      topRight: Radius.circular(40)
                  )
              ),
              padding: EdgeInsets.only(top: 45),
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
          Padding(
            padding: const EdgeInsets.only(top:200,left: 30),
            child: Container(child: Text("Messages",style: TextStyle(
                color: Color.fromARGB(255, 88, 45, 210),
                fontSize: 30,
                fontWeight: FontWeight.bold
            ))),
          ),



        ],
      ),
    );
  }

  
}