import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:i_chat/main.dart';
import 'package:i_chat/models/chatUse.dart';


class ProfileScreen extends StatefulWidget {
  // final ChatUser user;
  const ProfileScreen({super.key});



  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {


  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 88, 45, 210),
            ),
          ),
          Container(height:655,
            decoration: BoxDecoration(color: Colors.white,
                borderRadius: BorderRadius.only(topLeft:Radius.circular(45),topRight: Radius.circular(45))),),
          Positioned(
            top: 175,
            child: Column(
              children: [
                Container(
                  width: 144,
                  height: 144,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(175),
                    image: DecorationImage(image: AssetImage('images/man.png'),
                        fit: BoxFit.cover),
                  ),),
                Container(
                  width: mq.height *.40,
                  padding: EdgeInsets.only(top: 85),
                  child: Material(
                      child: TextField(style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          floatingLabelAlignment: FloatingLabelAlignment.start,
                          fillColor: Colors.white,
                          filled: true,
                          labelText: "Name",
                          labelStyle: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey,fontSize:24)
                      )),
                )
                ),
                Container(
                    width: mq.height *.40,
                    margin: EdgeInsets.only(top: 25),
                    child: Material(
                      child: TextField(
                          keyboardType: TextInputType.name,
                          style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                          decoration: InputDecoration(
                              floatingLabelAlignment: FloatingLabelAlignment.start,
                              fillColor: Colors.white,
                              filled: true,
                              labelText: "E-Mail",
                              labelStyle: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey,fontSize:24)
                          )),
                    )
                ),
                SizedBox(height: 45,),
                ElevatedButton(onPressed: (){},
                    child: Text("UPDATE",style: TextStyle(fontSize: 20,)),
                    style: ButtonStyle(backgroundColor:MaterialStatePropertyAll(Color.fromARGB(
                        255, 54, 59, 182)),
                    shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(25))),
                      minimumSize: MaterialStatePropertyAll(Size(192, 59))

                    )
                ),
              ],
            ),
          ),
          Positioned(
            top: 260,
            left: 235,
            child: FloatingActionButton(onPressed: () {},
                child:Icon(Icons.edit,color: Colors.black,),
                backgroundColor: Color.fromARGB(255, 217, 217, 217)),
          ),
          // ElevatedButton(onPressed: (){},
          //     child: Text("UPDATE",style: TextStyle(fontSize: 20,)),
          //     style: ButtonStyle(backgroundColor:MaterialStatePropertyAll(Color.fromARGB(
          //         255, 54, 59, 182)),
          //         shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(25))),
          //         minimumSize: MaterialStatePropertyAll(Size(192, 59))
          //
          //     )
          // ),
          Padding(
            padding: const EdgeInsets.only(bottom: 48.0,left: 200),
            child: SizedBox(
              height: 56,
              width: 160,
              child: FloatingActionButton.extended(onPressed: (){},
                  icon: Icon(Icons.logout),
                  label: Text("Log Out",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500)),
                  backgroundColor: Color.fromARGB(255, 222, 0, 0)),
            ),
          ),
        ],

    );

  }
}


//user profile picture
// Expanded(
//   child: ClipRRect(
//     borderRadius: BorderRadius.circular(10),
//     child: CachedNetworkImage(
//         imageUrl: widget.user.image,
//     errorWidget: (context, url, error) => const CircleAvatar(child: Icon(Icons.person),),),
//   ),
// )