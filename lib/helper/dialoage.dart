import 'package:flutter/material.dart';
import 'package:i_chat/main.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class Dialogs{
  static void showSnackBar(BuildContext context,String msg){
    showTopSnackBar(
      Overlay.of(context),

      CustomSnackBar.error(
          messagePadding: EdgeInsets.only(left: mq.height *.04),
          message:msg),
    );
  }


  static void showProgressBar(BuildContext context){
      showDialog(context: context, builder:(_)=>Center(child: CircularProgressIndicator()));
  }
}