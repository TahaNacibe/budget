import 'package:budget/models/transaction.dart';
import 'package:budget/models/user_model.dart';

List<Transaction> loadedTransactions = [];
UserModel loadedUser = UserModel(
    balance: 0.00,
    investBudget: 0.00,
    personalBudget: 0.00,
    requireBudget: 0.00,
    userName: "Yuki",
    pfp: "pfp");
