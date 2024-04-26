import 'package:intl/intl.dart';

String formateDate(DateTime dateTime) {
  return DateFormat("d MMM, yyyy").format(dateTime);
}
