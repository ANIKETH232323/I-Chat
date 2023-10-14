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
  List<ChatUser> _list = [];

  // for storing search items
  final List<ChatUser> _searchList = [];

  // for storing search status
  bool _isSearchOn = false;

  @override
  void initState() {
    super.initState();
    ApIs.userSelfInfo();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        if(_isSearchOn){
          setState(() {
            _isSearchOn = !_isSearchOn;
          });
          return Future.value(false);
        }
        else{
          return Future.value(true);
        }
      },
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 88, 45, 210),
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SafeArea(
            bottom: false,
            child: Stack(
              children: [
                Column(
                  children: [
                    Container(
                      alignment: Alignment.bottomLeft,
                      padding: EdgeInsets.only(
                          left: mq.height * .045, top: mq.height * .045),
                      child: IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => ProfileScreen(user: ApIs.me)));
                        },
                        icon: new Image.asset("images/acc.png"),
                      ),
                    ),

                    SizedBox(
                      height: mq.height * .015,
                    ),
                    Padding(
                      padding: EdgeInsets.all(mq.height * .019),
                      child: Container(
                      height: mq.height * .05,
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
                                    height: mq.height * .05,
                                      child: TextField(
                                        onTap: () {
                                          setState(() {
                                            _isSearchOn = !_isSearchOn;
                                          });
                                        },
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.only(bottom: 5),
                                        hintText: "Search Message Here",
                                        border: InputBorder.none,
                                    ),
                                        // when search  text changes it will update the search list
                                        onChanged: (value) {
                                          _searchList.clear();
                                          for(var i in _list){
                                            if(i.name.toLowerCase().contains(value.toLowerCase()) ||
                                                i.name.toUpperCase().contains(value.toUpperCase())){
                                              _searchList.add(i);
                                            }
                                            setState(() {
                                              _searchList;
                                            });
                                          }
                                        },
                                    ),
                                    )),
                                Icon( _isSearchOn ?
                                CupertinoIcons.clear_circled_solid:
                                Icons.search,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
                    Flexible(
                      fit: FlexFit.tight,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(25),
                                topLeft: Radius.circular(25))),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: StreamBuilder(
                            stream: ApIs.getAllUser(),
                            builder: (context, snapshot) {
                              switch (snapshot.connectionState) {
                                // if Data is loading
                                case ConnectionState.waiting:
                                case ConnectionState.none:
                                  return const Center(
                                      child: CircularProgressIndicator());
                                // if some or all data is loaded then show it
                                case ConnectionState.active:
                                case ConnectionState.done:
                                  final data = snapshot.data?.docs;
                                  _list = data
                                          ?.map((e) => ChatUser.fromJson(e.data()))
                                          .toList() ??
                                      [];

                              if (_list.isNotEmpty) {
                                return ListView.builder(
                                    physics: BouncingScrollPhysics(),
                                    itemCount: _isSearchOn ? _searchList.length : _list.length,
                                    itemBuilder: (context, index) {
                                      return chat_user_card(
                                        user:_isSearchOn? _searchList[index] : _list[index],
                                      );
                                      // return Text('Name:${list[index]}');
                                    });
                              } else {
                                return Center(
                                    child: Text(
                                      'No Connection Found',
                                      style: TextStyle(fontSize: 18),
                                    ));
                              }
                              }
                            },
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}


