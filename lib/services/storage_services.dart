import 'dart:convert';
import 'package:budget/keys/storage_keys.dart';
import 'package:budget/models/shop_item.dart';
import 'package:budget/models/transaction.dart';
import 'package:budget/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageServices {
  // Save UserModel to SharedPreferences
  Future<void> saveUserModel(UserModel user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String userJson = jsonEncode(user.toJson()); // Convert UserModel to JSON
    await prefs.setString(userDetailsKey, userJson); // Save JSON string
  }

  // Retrieve UserModel from SharedPreferences
  Future<UserModel?> getUserModel() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userJson = prefs.getString(userDetailsKey);

    if (userJson != null) {
      // Convert JSON string to UserModel
      Map<String, dynamic> userMap = jsonDecode(userJson);
      return UserModel.fromJson(userMap); // Deserialize UserModel
    }
    return null; // Return null if not found
  }

  // Clear UserModel from SharedPreferences
  Future<void> clearUserModel() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(userDetailsKey); // Clear the stored data
  }

  // Save list of Transactions to SharedPreferences
  Future<void> saveTransactions(List<Transaction> transactions) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> transactionList = transactions.map((transaction) {
      return jsonEncode(
          transaction.toJson()); // Convert each Transaction to JSON
    }).toList();

    await prefs.setStringList(
        transactionsKey, transactionList); // Save JSON strings as list
  }

  // Retrieve list of Transactions from SharedPreferences
  Future<List<Transaction>> getTransactions() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? transactionList = prefs.getStringList(transactionsKey);

    if (transactionList != null) {
      // Convert JSON strings back to Transaction objects
      return transactionList.map((transactionJson) {
        Map<String, dynamic> transactionMap = jsonDecode(transactionJson);
        return Transaction.fromJson(transactionMap); // Deserialize Transaction
      }).toList();
    }
    return []; // Return an empty list if not found
  }

  // Clear the list of transactions from SharedPreferences
  Future<void> clearTransactions() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(transactionsKey); // Clear the stored data
  }

  //* save list of items
  Future<void> saveListOfItems(
      {required List<ShopItem> list, required listKey}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<Map<String, dynamic>> jsonDataList =
        list.map((e) => e.toJson()).toList();
    String jsonString = jsonEncode(jsonDataList);
    await prefs.setString(listKey, jsonString);
  }

  //* read list of storage
  Future<List<ShopItem>> getShopItemsList({required String listKey}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? data = prefs.getString(listKey);
    if (data != null) {
      List<dynamic> jsonData = jsonDecode(data);
      List<ShopItem> result =
          jsonData.map((e) => ShopItem.fromJson(e)).toList();
      return result;
    } else {
      return [];
    }
  }

  //* save theme
  Future<void> saveThemeState({required bool state}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(themeKey, state);
  }

  //* load theme
  Future<bool> loadThemeState() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? result = prefs.getBool(themeKey);
    return result ?? false;
  }

  // Clear the list of transactions from SharedPreferences
  Future<void> clearItemsList() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(deleteInvestListKey); // Clear the stored data
    await prefs.remove(deletePersonnelUseListKey); // Clear the stored data
    await prefs.remove(deleteRequiredListKey); // Clear the stored data
  }
}
