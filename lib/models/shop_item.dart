class ShopItem {
  String name;
  String type;
  double price;
  bool isPayed;
  String parentClass;

  // Constructor
  ShopItem({
    required this.name,
    required this.type,
    required this.price,
    required this.parentClass,
    this.isPayed = false, // Default value for isPayed is false
  });

  // Method to convert the ShopItem to JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'type': type,
      'price': price,
      'parentClass': parentClass,
      'isPayed': isPayed,
    };
  }

  // Method to create a ShopItem from JSON
  factory ShopItem.fromJson(Map<String, dynamic> json) {
    return ShopItem(
      name: json['name'],
      type: json['type'],
      parentClass:  json['parentClass'],
      price: json['price'].toDouble(), // Ensure price is treated as double
      isPayed: json['isPayed'] ?? false, // Default to false if not provided
    );
  }
}
