import 'package:intl/intl.dart';

String dateFormatted() {
  var now = DateTime.now();
  var formatter = new DateFormat("EEEE HH:mm d/M/y");
  return formatter.format(now);
}
