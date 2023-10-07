import 'package:flutter/material.dart';
import 'package:i_chat/widgets/chat_user_card.dart';

class homeScreenAppBar extends StatelessWidget {
  const homeScreenAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.square(185),
        child: AppBar(
          toolbarHeight: 80,
          title: Text("I Chat"),
          centerTitle: true,
          leading: IconButton(
              onPressed: () {},
              icon: Image.asset(
                'images/acc.png',
                width: 85,
                height: 85,
              ),
              padding: EdgeInsets.only(left: 15)
              // EdgeInsets.symmetric(horizontal: mq.width * .02, vertical: 10),
              ),
          actions: [
            // 3dot button
            IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),


          ],
          backgroundColor: Color.fromARGB(255, 88, 45, 210),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25)),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Column(

          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: TextField(
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.deepOrange,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25)
                        )
                    ) ,
                  ),
                ),
              ],
            ),
            Container(
              child: Text("Messages",
                  style: TextStyle(
                      color: Color.fromARGB(255, 88, 45, 210),
                      fontSize: 30,
                      fontWeight: FontWeight.bold)),
              padding: EdgeInsets.only(left: 30, bottom: 8),
            ),
            Flexible(
              child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 15,
                  itemBuilder: (context, index) {
                    return chat_user_card();
                  }),
            ),
          ],
        ),
      ),
    );

  }
}

// TextField(
// decoration: InputDecoration(
// filled: true,
// fillColor: Colors.deepOrange,
// border: OutlineInputBorder(
// borderRadius: BorderRadius.circular(25)
// )
// ) ,
// );