
class UserModel {
  double balance;
  double investBudget;
  double personalBudget;
  double requireBudget;
  String userName;
  String pfp; // Profile picture URL or file path

  // Constructor
  UserModel({
    required this.balance,
    required this.investBudget,
    required this.personalBudget,
    required this.requireBudget,
    required this.userName,
    required this.pfp,
  });

  // Method to convert UserModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'balance': balance,
      'investBudget': investBudget,
      'personalBudget': personalBudget,
      'requireBudget': requireBudget,
      'userName': userName,
      'pfp': pfp,
    };
  }

  // Factory method to create a UserModel from JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      balance: json['balance'],
      investBudget: json['investBudget'],
      personalBudget: json['personalBudget'],
      requireBudget: json['requireBudget'],
      userName: json['userName'],
      pfp: json['pfp'],
    );
  }
}
