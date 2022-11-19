

import 'package:intl/intl.dart';


class  Timeinterval{
  String getCurrentDate(){
    DateTime dateTime=DateTime.now();
        return DateFormat.MMMMEEEEd().format(dateTime);
  }
 String getCurrentTime(){
    DateTime dateTime=DateTime.now();
    return DateFormat.jms().format(dateTime);
 }
}