import 'package:budget/dialogs/fast_snack_bar.dart';
import 'package:budget/models/shop_item.dart';
import 'package:budget/services/data_manager.dart';
import 'package:flutter/material.dart';
import 'package:budget/keys/types_keys.dart';
import 'package:budget/models/transaction.dart';
import 'package:budget/services/storage_services.dart';
import 'package:budget/models/user_model.dart';

class BudgetProvider with ChangeNotifier {
  //* Storage service instance
  final StorageServices _storageServices = StorageServices();
  final DataManager _dataManager = DataManager();

  //* Loaded data
  UserModel loadedUser = UserModel(
    balance: 0.00,
    investBudget: 0.00,
    personalBudget: 0.00,
    requireBudget: 0.00,
    userName: "Yuki",
    pfp: "pfp",
  );

  List<Transaction> loadedTransactions = [];

  List<ShopItem> loadedInvestList = [];
  List<ShopItem> loadedPersonalList = [];
  List<ShopItem> loadedRequiredList = [];

  //* theme
  bool isDarkTheme = false;

  void toggleTheme() {
    isDarkTheme = !isDarkTheme;
    _storageServices.saveThemeState(state: isDarkTheme);
    notifyListeners();
  }

  bool getThemeState() {
    return isDarkTheme;
  }

  //* Retrieve data from storage
  Future<void> loadUserData(BuildContext context) async {
    try {
      UserModel? user = await _storageServices.getUserModel();
      if (user != null) {
        loadedUser = user;
        notifyListeners(); // Notify UI about the change
      }
    } catch (e) {
      informationBar(context, "Error loading user data: $e");
    }
  }

  Future<void> loadThemeState() async {
    isDarkTheme = await _storageServices.loadThemeState();
    notifyListeners();
  }

  Future<void> loadTransactionData(BuildContext context) async {
    try {
      List<Transaction>? transactions =
          await _storageServices.getTransactions();
      loadedTransactions = transactions;
      notifyListeners(); // Notify UI about the change
    } catch (e) {
      informationBar(context, "Error loading transaction data: $e");
    }
  }

  Future<void> loadInvestmentsList(BuildContext context) async {
    try {
      //* load investments list
      List<ShopItem> investment =
          await _storageServices.getShopItemsList(listKey: investments);
      loadedInvestList = investment;
      notifyListeners();
    } catch (e) {
      informationBar(context, "Failed to load investments $e");
    }
  }

  Future<void> loadPersonalList(BuildContext context) async {
    try {
      //* load investments list
      List<ShopItem> investment =
          await _storageServices.getShopItemsList(listKey: personalUse);
      loadedPersonalList = investment;
      notifyListeners();
    } catch (e) {
      informationBar(context, "Failed to load Personal use $e");
    }
  }

  Future<void> loadRequiredList(BuildContext context) async {
    try {
      //* load investments list
      List<ShopItem> investment =
          await _storageServices.getShopItemsList(listKey: requirements);
      loadedRequiredList = investment;
      notifyListeners();
    } catch (e) {
      informationBar(context, "Failed to load Required List $e");
    }
  }

  //* add new shop item
  void addNewShopItem({required String listKey, required ShopItem item}) {
    switch (listKey) {
      case investments:
        loadedInvestList.add(item);
        _storageServices.saveListOfItems(
            list: loadedInvestList, listKey: listKey);
        break;
      case personalUse:
        loadedPersonalList.add(item);
        _storageServices.saveListOfItems(
            list: loadedPersonalList, listKey: listKey);
        break;
      case requirements:
        loadedRequiredList.add(item);
        _storageServices.saveListOfItems(
            list: loadedRequiredList, listKey: listKey);
        break;
      default:
    }
    notifyListeners();
  }

  //* add new shop item
  void removeNewShopItem({required String listKey, required int index}) {
    switch (listKey) {
      case investments:
        loadedInvestList.removeAt(index);
        _storageServices.saveListOfItems(
            list: loadedInvestList, listKey: listKey);
        break;
      case personalUse:
        loadedPersonalList.removeAt(index);
        _storageServices.saveListOfItems(
            list: loadedPersonalList, listKey: listKey);
        break;
      case requirements:
        loadedRequiredList.removeAt(index);
        _storageServices.saveListOfItems(
            list: loadedRequiredList, listKey: listKey);
        break;
      default:
    }
    notifyListeners();
  }

  //* update a shop item
  void updateShopItem(
      {required int index,
      required ShopItem item,
      required String listKey,
      required String newName,
      required double newValue}) {
    item.name = newName;
    item.price = newValue;
    switch (listKey) {
      case investments:
        loadedInvestList[index] = item;
        _storageServices.saveListOfItems(
            list: loadedInvestList, listKey: listKey);
        break;
      case personalUse:
        loadedPersonalList[index] = item;
        _storageServices.saveListOfItems(
            list: loadedPersonalList, listKey: listKey);
        break;
      case requirements:
        loadedRequiredList[index] = item;
        _storageServices.saveListOfItems(
            list: loadedRequiredList, listKey: listKey);
        break;
      default:
    }
    notifyListeners();
  }

  //* handle balance change after item state switch
  void handleBalanceChange(
      {required double price,
      required bool isPaying,
      required String itemName,
      required String parentClass}) {
    // manage total balance change
    if (isPaying) {
      // to create a withdraw action
      addNewTransaction(typeKey: parentClass, value: price * (-1),itemAction: itemName);
    } else {
      addNewTransaction(typeKey: parentClass, value: price,itemAction: itemName);
    }
  }

  //* switch item state
  void setItemUnpaidOrPaid({required ShopItem item, required int index}) {
    switch (item.parentClass) {
      case investments:
        loadedInvestList[index].isPayed = !loadedInvestList[index].isPayed;
        handleBalanceChange(
            price: item.price,
            itemName: item.name,
            isPaying: item.isPayed,
            parentClass: item.parentClass);
        _storageServices.saveListOfItems(
            list: loadedInvestList, listKey: item.parentClass);
        break;
      case personalUse:
        loadedPersonalList[index].isPayed = !loadedPersonalList[index].isPayed;
        handleBalanceChange(
            price: item.price,
            itemName: item.name,
            isPaying: item.isPayed,
            parentClass: item.parentClass);
        _storageServices.saveListOfItems(
            list: loadedPersonalList, listKey: item.parentClass);
        break;
      case requirements:
        loadedRequiredList[index].isPayed = !loadedRequiredList[index].isPayed;
        handleBalanceChange(
            price: item.price,
            itemName: item.name,
            isPaying: item.isPayed,
            parentClass: item.parentClass);
        _storageServices.saveListOfItems(
            list: loadedRequiredList, listKey: item.parentClass);
        break;
      default:
    }
    notifyListeners();
  }

  //* Add a new transaction
  void addNewTransaction({required String typeKey, required double value, String? itemAction = null}) {
    bool isAdd = value > 0;

    // Create transaction
    Transaction item = Transaction(
        value: value,
        type: typeKey,
        itemName: itemAction,
        isWithdraw: !isAdd,
        timestamp: DateTime.now());

    // Add to list
    loadedTransactions.add(item);

    // Save transactions to storage
    _storageServices.saveTransactions(loadedTransactions);

    // Update budget values
    editBudgetValue(value: value, key: typeKey);

    // Notify listeners
    notifyListeners();
  }

  //* Edit budget value
  void editBudgetValue({required double value, required String key}) {
    loadedUser.balance += value;

    switch (key) {
      case investments:
        loadedUser.investBudget += value;
        break;
      case personalUse:
        loadedUser.personalBudget += value;
        break;
      case requirements:
        loadedUser.requireBudget += value;
        break;
      default:
        return; // Exit if key is invalid
    }

    // Save user model to storage
    _storageServices.saveUserModel(loadedUser);
    notifyListeners(); // Notify UI about the change
  }

  //* update profile data
  void userProfileEdit({required String newUserName, required String newPfp}) {
    loadedUser.pfp = newPfp;
    loadedUser.userName = newUserName;
    _storageServices.saveUserModel(loadedUser);
    notifyListeners();
  }

  //* Edit balance
  void editBalance({required double value}) {
    loadedUser.balance += value;
    double shareForEach = value / 3;

    // Update categories
    loadedUser.investBudget += shareForEach;
    loadedUser.personalBudget += shareForEach;
    loadedUser.requireBudget += shareForEach;

    // Add transaction
    loadedTransactions.add(Transaction(
      value: value,
      type: balance,
      isWithdraw: value < 0,
      timestamp: DateTime.now(),
    ));

    // Save data
    _storageServices.saveTransactions(loadedTransactions);
    _storageServices.saveUserModel(loadedUser);
    notifyListeners(); // Notify UI about the change
  }

  //* Utility: Get value from user input
  double? getValueOfUserInput(
      {required String input, required BuildContext context}) {
    try {
      double value = double.parse(input);
      return value;
    } catch (e) {
      informationBar(context, "Invalid input value: $input");
      return null; // Return null if input cannot be parsed
    }
  }

  //* save data in buckUp
  Future<bool> createBuckUp(BuildContext context) async {
    try {
      _dataManager.saveUserDataToFile(context, loadedUser, loadedTransactions,
          loadedInvestList, loadedPersonalList, loadedRequiredList);
      return true;
    } catch (e) {
      informationBar(context, "Failed To create BackUp $e");
      return false;
    }
  }

  //* Load data from backup file
  Future<bool?> loadBuckUpFile(BuildContext context) async {
    try {
      Map<String, dynamic>? userBackUp =
          await _dataManager.loadUserDataFromFile(context);

      if (userBackUp != null) {
        //* Update current data
        loadedUser = userBackUp["userData"];
        loadedTransactions = userBackUp["transactions"];
        loadedInvestList = userBackUp[investments];
        loadedPersonalList = userBackUp[personalUse];
        loadedRequiredList = userBackUp[requirements];

        //* Save updated data
        _storageServices.saveUserModel(loadedUser);
        _storageServices.saveTransactions(loadedTransactions);
        _storageServices.saveListOfItems(
          list: loadedInvestList,
          listKey: "investments", // Ensure the correct key is used
        );
        _storageServices.saveListOfItems(
          list: loadedPersonalList,
          listKey: "personalUse", // Ensure the correct key is used
        );
        _storageServices.saveListOfItems(
          list: loadedRequiredList,
          listKey: "requirements", // Ensure the correct key is used
        );

        //* Update the UI
        notifyListeners();
        return true;
      }
      return null;
    } catch (e) {
      informationBar(context, "Can't load backUp $e");
      return false;
    }
  }

  //* manage clear all
  Future<bool> clearAllData() async {
    try {
      await _storageServices.clearTransactions();
      await _storageServices.clearUserModel();
      await _storageServices.clearItemsList();
      return true;
    } catch (e) {
      return false;
    }
  }
}
