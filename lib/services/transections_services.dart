import 'package:budget/models/transaction.dart';
import 'package:budget/services/amount_services.dart';
import 'package:intl/intl.dart';

String formatTransactionInfo(Transaction item) {
  // Format the timestamp to include date, hour, and minute
  String formattedDateTime =
      DateFormat('MMMM d, y, h:mm a').format(item.timestamp);

  // Format the value using your existing formatNumber function
  String formattedValue = formatNumber(item.value);

  // get item name if action related to item
  String itemTag = item.itemName != null
      ? "- ${item.isWithdraw ? "Paid" : "Retrieved"} For ${item.itemName}\n"
      : "";

  // Construct the final message
  return "- This transaction was on $formattedDateTime,\n"
      "$itemTag"
      "- in ${item.type} category,\n- with a value of \$$formattedValue.";
}
