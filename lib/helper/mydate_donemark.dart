import 'package:flutter/material.dart';

class MyDate{

  // for getting formatted time from milli seconds epoch String
  static String getFormattedTime({required BuildContext context,required String time}){
    final date  = DateTime.fromMillisecondsSinceEpoch(int.parse(time));
    return TimeOfDay.fromDateTime(date).format(context);
  }

  static String getLastMessageTime({required BuildContext context,required String sent}){
    final DateTime dateTime  = DateTime.fromMillisecondsSinceEpoch(int.parse(sent));
    final DateTime now = DateTime.now();

    if(now.day == dateTime.day && now.month == dateTime.month && now.year == dateTime.year){
        return TimeOfDay.fromDateTime(dateTime).format(context);
    }

    return '${dateTime.day} ${_getMonth(dateTime)}';
  }
  static String _getMonth(DateTime dateTime){

    switch(dateTime.month){
      case 1:
        return 'Jan';

        case 2:
          return 'Jan';

        case 3:
          return 'Jan';

        case 4:
          return 'Jan';

        case 5:
          return 'Jan';

        case 6:
          return 'Jan';

        case 7:
          return 'Jan';

        case 8:
          return 'Jan';

        case 9:
          return 'Jan';

        case 10:
          return 'Jan';

        case 11:
          return 'Jan';

        case 12:
          return 'Jan';
    }
    return 'NA';

  }




}