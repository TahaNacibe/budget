import 'package:intl/intl.dart';

String formatDateTime(DateTime dateTime) {
  // Define the format pattern "EEE.dd MMM, yyyy"
  final DateFormat formatter = DateFormat('EEE.dd MMM, yyyy');
  
  // Return the formatted date string
  return formatter.format(dateTime);
}
