import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:i_chat/appBar/homeScreenAppBar.dart';
import 'package:i_chat/main.dart';

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
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(35),
                      topRight: Radius.circular(35))),
              height: double.infinity,
              margin: EdgeInsets.only(top: mq.height * .25),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Column(
                children: [
                  _HeaderSection(),
                  searchBox(),
                ],
              ),
            )
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
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white60,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: Colors.white)

      ),
      child: Column(
        children: [
          Row(
            children: [
              Image.asset('images/search.png')
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
        // Padding(
        //   padding: const EdgeInsets.only(top: 120.0),
        //   child: SizedBox(
        //     width: 360,
        //     height: 40,
        //     child: TextField(
        //       decoration: InputDecoration(
        //           filled: true,
        //           contentPadding: EdgeInsets.symmetric(horizontal: 18),
        //           hintText: 'Search Messages',
        //           hintStyle: TextStyle(color: Colors.white,),
        //           fillColor: Colors.white30,
        //           border: OutlineInputBorder(
        //               borderRadius: BorderRadius.circular(25))),
        //     ),
        //   ),
        // ),

      ],
    );
  }
}
