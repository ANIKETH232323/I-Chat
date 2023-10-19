import 'package:flutter/material.dart';

class MyDate{

  // for getting formatted time from milli seconds epoch String
  static String getFormattedTime({required BuildContext context,required String time}){
    final date  = DateTime.fromMillisecondsSinceEpoch(int.parse(time));
    return TimeOfDay.fromDateTime(date).format(context);
  }


  // getting formated time for last seen and read time

  static String getLastSeenReadTime(
      {required BuildContext context,
        required String time,
        }) {
    final DateTime sent = DateTime.fromMillisecondsSinceEpoch(int.parse(time));
    final DateTime now = DateTime.now();

    final formattedtime = TimeOfDay.fromDateTime(sent).format(context);
    if (now.day == sent.day &&
        now.month == sent.month &&
        now.year == sent.year) {
      return formattedtime;
    }

    return now.year ==sent.year
        ? '$formattedtime - ${sent.day} ${_getMonth(sent)}'
        : '$formattedtime - ${sent.day} ${_getMonth(sent)} ${sent.year}';
  }



  static String getLastMessageTime(
      {required BuildContext context,
        required String sent1,
        bool showYear = false}) {
    final DateTime sent = DateTime.fromMillisecondsSinceEpoch(int.parse(sent1));
    final DateTime now = DateTime.now();

    if (now.day == sent.day &&
        now.month == sent.month &&
        now.year == sent.year) {
      return TimeOfDay.fromDateTime(sent).format(context);
    }

    return showYear
        ? '${sent.day} ${_getMonth(sent)} ${sent.year}'
        : '${sent.day} ${_getMonth(sent)}';
  }



  static String _getMonth(DateTime dateTime){

    switch(dateTime.month){
      case 1:
        return 'Jan';

        case 2:
          return 'Feb';

        case 3:
          return 'March';

        case 4:
          return 'April';

        case 5:
          return 'May';

        case 6:
          return 'June';

        case 7:
          return 'July';

        case 8:
          return 'August';

        case 9:
          return 'September';

        case 10:
          return 'October';

        case 11:
          return 'November';

        case 12:
          return 'December';
    }
    return 'NA';

  }


  //get formatted last active time of user in chat screen
  static String getLastActiveTime({required BuildContext context, required String lastActive}) {
    final int i = int.tryParse(lastActive) ?? -1;

    //if time is not available then return below statement
    if (i == -1) return 'Last seen not available';

    DateTime time = DateTime.fromMillisecondsSinceEpoch(i);
    DateTime now = DateTime.now();

    String formattedTime = TimeOfDay.fromDateTime(time).format(context);
    if (time.day == now.day &&
        time.month == now.month &&
        time.year == time.year) {
      return 'Last seen today at $formattedTime';
    }

    if ((now.difference(time).inHours / 24).round() == 1) {
      return 'Last seen yesterday at $formattedTime';
    }

    String month = _getMonth(time);
    return 'Last seen on ${time.day} $month on $formattedTime';
  }




}