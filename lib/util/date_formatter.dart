import 'package:intl/intl.dart';

/*
  Auther: Anders Mæhlum Halvorsen
*/
String dateFormatted() {
  var now = DateTime.now();
  var formatter = new DateFormat("EEEE HH:mm d/M/y");
  return formatter.format(now);
}
