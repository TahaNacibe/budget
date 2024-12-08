class Transaction {
  double value;
  String type;
  String? itemName;
  bool isWithdraw;
  DateTime timestamp;

  // Constructor
  Transaction({
    required this.value,
    required this.type,
    required this.isWithdraw,
    required this.timestamp,
    this.itemName
  });

  // Method to convert a Transaction object to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'value': value,
      'type': type,
      'itemName':itemName,
      'isWithdraw': isWithdraw,
      'timestamp': timestamp.toIso8601String(), // Converts DateTime to string
    };
  }

  // Factory method to create a Transaction object from a JSON map
  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      value: json['value'],
      type: json['type'],
      itemName: json['itemName'],
      isWithdraw: json['isWithdraw'],
      timestamp:
          DateTime.parse(json['timestamp']), // Converts string to DateTime
    );
  }
}
