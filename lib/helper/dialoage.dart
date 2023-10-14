import 'package:flutter/material.dart';
import 'package:i_chat/main.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class Dialogs{
  static void showSnackBar(BuildContext context,String msg){
    showTopSnackBar(
      Overlay.of(context),

      CustomSnackBar.error(message:msg),
    );
  }
  static void showSnackBarSuccessful(BuildContext context,String msg){
    showTopSnackBar(
      Overlay.of(context),

      CustomSnackBar.success(message:msg),
    );
  }
  static void showSnackBarForProfileScreen(BuildContext context,String msg){
    showTopSnackBar(
      Overlay.of(context),

      CustomSnackBar.success(
          messagePadding: EdgeInsets.only(left: mq.height *.04),
          message:msg,
          icon: Transform.rotate(
            angle: 12,
            child: Padding(
              padding: EdgeInsets.all(mq.height *.02),
              child: Image(image: AssetImage('images/check.png'),height:mq.height *.34,),
            ),
          )),
    );
  }


  static void showProgressBar(BuildContext context){
      showDialog(context: context, builder:(_)=>Center(child: CircularProgressIndicator()));
  }
}