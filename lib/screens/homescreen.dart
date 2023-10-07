import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:i_chat/appBar/homeScreenAppBar.dart';
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
      backgroundColor: Color.fromARGB(255, 88, 45, 210),
      body: SafeArea(
        child: Stack(
          children: [
            Card(
              margin: EdgeInsets.only(top: 158),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25))),

              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: ListView.builder(

                    physics: BouncingScrollPhysics(),
                    itemCount: 15,
                    itemBuilder: (context, index) {
                      return chat_user_card();
                    }),
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
        bottom: false,
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
              Flexible(child: SizedBox(
                height: 40,
                child: TextField(
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(bottom: 10),
                    hintText: "Search Message Here",
                    border: InputBorder.none,
                  ),
                ),
              )),
              Icon(Icons.search,),
            ],
          )
        ],
      ),
    );
  }
}


class _HeaderSection extends StatelessWidget {
  const _HeaderSection({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircleAvatar(
              radius: 25,
              backgroundImage: AssetImage('images/acc.png'),
            ),
            Custom_Navigation_Button(
              icon: Icon(Icons.menu_rounded),
            )
          ],
        ),

      ],
    );
  }
}
