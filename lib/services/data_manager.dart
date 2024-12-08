import 'dart:convert';
import 'dart:io';

import 'package:budget/dialogs/fast_snack_bar.dart';
import 'package:budget/keys/types_keys.dart';
import 'package:budget/models/shop_item.dart';
import 'package:budget/models/transaction.dart';
import 'package:budget/models/user_model.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class DataManager {
  Future<void> saveUserDataToFile(
    BuildContext context,
    UserModel userData,
    List<Transaction> transactions,
    List<ShopItem> investList,
    List<ShopItem> personalList,
    List<ShopItem> requiredList,
  ) async {
    try {
      // Request permissions
      var manageExternalStorageStatus =
          await Permission.manageExternalStorage.request();
      var storageStatus = await Permission.storage.request();
      if (manageExternalStorageStatus.isDenied || storageStatus.isDenied) {
        return; // Exit if permission is denied
      }

      // Prepare the data to be saved
      Map<String, dynamic> dataToSave = {
        'userData': userData.toJson(),
        'transactions': transactions.map((tx) => tx.toJson()).toList(),
        'investments': investList.map((e) => e.toJson()).toList(),
        'personalUse': personalList.map((e) => e.toJson()).toList(),
        'requirements': requiredList.map((e) => e.toJson()).toList(),
      };

      String jsonString = jsonEncode(dataToSave);
      if (jsonString.isEmpty) return; // Prevent saving if there's no data

      // Prompt user to select a directory to save the file
      String? directoryPath = await FilePicker.platform.getDirectoryPath(
        dialogTitle: 'Select Directory to Save Data',
      );

      if (directoryPath != null) {
        File file = await File("$directoryPath/user_data.json").create();
        await file.writeAsString(jsonString);
      }
    } catch (e) {
      // Handle any errors
      informationBar(context,"Error Creating BuckUp: $e");
    }
  }

  Future<Map<String, dynamic>?> loadUserDataFromFile(
      BuildContext context) async {
    try {
      // Request permissions
      var storageStatus = await Permission.storage.request();
      var manageExternalStorageStatus =
          await Permission.manageExternalStorage.request();
      if (storageStatus.isDenied || manageExternalStorageStatus.isDenied) {
        return null; // Exit if permission is denied
      }

      // Prompt user to pick a file to load the data from
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        dialogTitle: 'Select User Data File',
        type: FileType.custom,
        allowedExtensions: ['json'],
      );

      if (result != null && result.files.single.path != null) {
        String filePath = result.files.single.path!;

        // Read the file contents
        File file = File(filePath);
        String fileContent = await file.readAsString();

        // Convert JSON data to a map
        Map<String, dynamic> jsonMap = jsonDecode(fileContent);

        // Retrieve user data and transactions
        UserModel userData = UserModel.fromJson(jsonMap['userData']);
        List<Transaction> transactions = (jsonMap['transactions'] as List)
            .map((tx) => Transaction.fromJson(tx))
            .toList();
        List<ShopItem> investList = (jsonMap["investments"] as List)
            .map((item) => ShopItem.fromJson(item))
            .toList();
        List<ShopItem> personalList = (jsonMap['personalUse'] as List)
            .map((item) => ShopItem.fromJson(item))
            .toList();
        List<ShopItem> requiredList = (jsonMap["requirements"] as List)
            .map((item) => ShopItem.fromJson(item))
            .toList();

        return {
          'userData': userData,
          'transactions': transactions,
          investments: investList,
          personalUse: personalList,
          requirements: requiredList,
        };
      }
      return null;
    } catch (e) {
      // Handle any errors
      informationBar(context, "Can't load buckUp $e");
      return null;
    }
  }
}
