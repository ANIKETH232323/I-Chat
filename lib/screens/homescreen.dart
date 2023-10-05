import 'package:flutter/material.dart';

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
      appBar: AppBar(
        leading: const Icon(Icons.home),
          title: const Text('I Chat'),
        actions: [
          // search button
          IconButton(onPressed: (){}, icon: const Icon(Icons.search)),

          // 3dot button
          IconButton(onPressed: (){}, icon: const Icon(Icons.more_vert))
        ],
          ),

      // floating action button to add user;
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 30,right: 10),
        child: FloatingActionButton(onPressed: (){},child: const Icon(Icons.add_comment_rounded
        ),),
      ),
    );
  }
}
