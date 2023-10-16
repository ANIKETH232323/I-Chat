import 'package:flutter/material.dart';

class MyDate{

  // for getting formatted time from milli seconds epoch String
  static String getFormattedTime({required BuildContext context,required String time}){
    final date  = DateTime.fromMicrosecondsSinceEpoch(int.parse(time));
    return TimeOfDay.fromDateTime(date).format(context);
  }




}