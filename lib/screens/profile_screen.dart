
import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:i_chat/api/apis.dart';
import 'package:i_chat/helper/dialoage.dart';
import 'package:i_chat/main.dart';
import 'package:i_chat/models/chatUse.dart';
import 'package:i_chat/screens/auth/login_screen.dart';
import 'package:image_picker/image_picker.dart';


class ProfileScreen extends StatefulWidget {
  final ChatUser user;
  const   ProfileScreen({super.key, required this.user});



  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey =  GlobalKey<FormState>();
  String? _image;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Form(
        key: _formKey,
        child: Stack(
          alignment: Alignment.bottomCenter,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 88, 45, 210),
                ),
              ),
              Container(
                height:mq.height * .71,
                decoration: BoxDecoration(color: Colors.white,
                    borderRadius: BorderRadius.only(topLeft:Radius.circular(45),topRight: Radius.circular(45))),),
              Positioned(
                top: mq.height * .16,
                child: Column(
                  children: [
                    _image != null ?
                        // for selecting local image
                    ClipRRect(
                      child: Image.file(
                        File(_image!),
                        fit: BoxFit.cover,
                        width: mq.height *.2,
                        height: mq.height *.2,
                      ),
                      borderRadius: BorderRadius.circular(mq.height *.2),
                    ) :
                    // Profile Picture from defult gmail image
                    ClipRRect(
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        width: mq.height *.2,
                        height: mq.height *.2,
                        imageUrl: widget.user.image,
                        // placeholder: (context, url) => CircularProgressIndicator(),
                        errorWidget: (context, url, error) => CircleAvatar(child: Icon(CupertinoIcons.person),backgroundColor: Colors.amberAccent),
                      ),
                      borderRadius: BorderRadius.circular(mq.height *.2),
                    ),
                    SizedBox(height: mq.height * .02,),
                    // Edit Name
                    Container(
                      width: mq.height *.40,
                      // padding: EdgeInsets.only(top:mq.height * .1),
                      child: Material(
                          child: TextFormField(
                            onSaved: (newValue) => ApIs.me.name = newValue ?? '',
                            validator: (value) => value != null &&  value.isNotEmpty ? null :'Required Field',
                            initialValue: widget.user.name,
                              style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
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
                    // Mail Box
                    Container(
                        width: mq.height *.40,
                        margin: EdgeInsets.only(top: mq.height * .025),
                        child: Material(
                          child: TextFormField(
                            initialValue: widget.user.email,
                              enabled: false,
                              keyboardType: TextInputType.name,
                              style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.black54),
                              decoration: InputDecoration(
                                  floatingLabelAlignment: FloatingLabelAlignment.start,
                                  fillColor: Colors.white,
                                  filled: true,

                                  labelText: "E-Mail",
                                  labelStyle: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize:24)
                              )),
                        )
                    ),
                    // About Section
                    Container(
                        width: mq.height *.40,
                        margin: EdgeInsets.only(top: mq.height * .025),
                        child: Material(
                          child: TextFormField(
                              onSaved: (val) => ApIs.me.about = val ?? '',
                              validator: (val) => val != null &&  val.isNotEmpty ? null :'Required Field',
                            initialValue: widget.user.about,
                              keyboardType: TextInputType.name,
                              style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),
                              decoration: InputDecoration(
                                  floatingLabelAlignment: FloatingLabelAlignment.start,
                                  fillColor: Colors.white,
                                  filled: true,
                                  labelText: "About",
                                  labelStyle: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey,fontSize:24)
                              )),
                        )
                    ),
                    SizedBox(height: mq.height *.015),


                    // Update Button
                    ElevatedButton(onPressed: (){
                      if(_formKey.currentState!.validate()){
                        _formKey.currentState!.save();
                        ApIs.changeNamAbout();
                        Dialogs.showSnackBarForProfileScreen(context, 'Details Updated Successfully');
                      }
                    },
                        child: Text("UPDATE",style: TextStyle(fontSize: 20,)),
                        style: ButtonStyle(backgroundColor:MaterialStatePropertyAll(Color.fromARGB(
                            255, 54, 59, 182)),
                        shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(25))),
                          minimumSize: MaterialStatePropertyAll(Size(140, 55))

                        )
                    ),
                  ],
                ),
              ),

              // Edit Button Of Profile Picture
              Positioned(
                top: mq.height * .30,
                left: mq.width * .59,
                child: FloatingActionButton(onPressed: () {

                  _showBottomSheet();
                },
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

              // Log Out Button
              Padding(
                padding:  EdgeInsets.only(bottom: mq.height * .03,left: mq.height * .2),
                child: SizedBox(
                  height: mq.height * .065,
                  width: mq.width * .40,
                  child: FloatingActionButton.extended(onPressed: () async {
                    Dialogs.showProgressBar(context);
                    await ApIs.auth.signOut().then((value) async => {
                    await GoogleSignIn().signOut().then((value) => {
                      Navigator.pop(context),
                      Navigator.pop(context),
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => Loginscreen()))
                    })
                    });

                  },
                      icon: Icon(Icons.logout),
                      label: Text("Log Out",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500)),
                      backgroundColor: Color.fromARGB(255, 222, 0, 0)),
                ),
              ),
            ],

        ),
      ),
    );
  }

  void _showBottomSheet(){
    showModalBottomSheet(context: context,
        showDragHandle: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(25),
                topRight: Radius.circular(25))),
        builder: (_){
      return ListView(
        shrinkWrap: true,
        padding: EdgeInsets.only(top: mq.height * .015, bottom: mq.height * .1),
        children: [
          Text("Pick Profile Picture",
            style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,),textAlign: TextAlign.center,),
          SizedBox(height: mq.height * .07  ,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [

              // From gallery

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                shape: CircleBorder(),
                fixedSize: Size(mq.width * .24, mq.height * .1)
              ),
                onPressed: () async {
                  final ImagePicker picker = ImagePicker();
                  final XFile? image = await picker.pickImage(source: ImageSource.gallery,imageQuality: 80);
                  if(image != null){
                    setState(() {
                      _image = image.path;
                    });
                    ApIs.updateProfilePicture(File(_image!));
                    // log('Image Path: ${image.path} -- Mime Type: ${image.mimeType}');
                  }
                  Navigator.pop(context);
                },
                child: Image.asset("images/add_image.png")),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                shape: CircleBorder(),
                fixedSize: Size(mq.width * .24, mq.height * .1)
              ),
                onPressed: () async {
                    final ImagePicker picker = ImagePicker();
                    final XFile? image = await picker.pickImage(source: ImageSource.camera,imageQuality: 80);
                    if(image != null){
                      setState(() {
                        _image = image.path;
                      });
                      ApIs.updateProfilePicture(File(_image!));
                      Dialogs.showSnackBarPictureUpdateSuccessful(context, 'Profile Picture Updated Successfully');
                        // log('Image Path: ${image.path} -- Mime Type: ${image.mimeType}');
                    }
                    Navigator.pop(context);
                },
                child: Image.asset("images/camera_add.png"))
          ],)
        ],
      );
    });
  }


}
