import 'package:budget/providers/data_provider.dart';
import 'package:budget/sheets/type_sheet.dart';
import 'package:budget/widgets/user_pfp.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

int _currentIndex = 0;
Widget costumeNavBar(void Function(int index) onChange) {
  return StatefulBuilder(builder: (context, setState) {
    void onItemChange({required int i}) {
      if (i != 2) {
        setState(() {
          _currentIndex = i;
          if (i > 2) {
            onChange(_currentIndex - 1);
          } else {
            onChange(_currentIndex);
          }
        });
      } else {
        // show new entry bottom sheet
        showTypeSectionSheet(context);
      }
    }

    return Consumer<BudgetProvider>(builder: (context, budgetProvider, child) {
      Color scaffoldColor = Theme.of(context).scaffoldBackgroundColor;
      return SalomonBottomBar(
        itemPadding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
        currentIndex: _currentIndex,
        backgroundColor: scaffoldColor,
        onTap: (i) => onItemChange(i: i),
        items: [
          /// Home
          SalomonBottomBarItem(
            icon: const Icon(Icons.home),
            title: const Text("Home"),
            selectedColor: Colors.purple,
          ),

          /// History
          SalomonBottomBarItem(
            icon: const Icon(Icons.history_rounded),
            title: const Text("History"),
            selectedColor: Colors.teal,
          ),

          /// add
          SalomonBottomBarItem(
            icon: const Icon(Icons.add),
            title: const Text("Add"),
            selectedColor: Colors.pink,
          ),

          /// Search
          SalomonBottomBarItem(
            icon: const Icon(Icons.search),
            title: const Text("Search"),
            selectedColor: Colors.orange,
          ),

          /// Profile
          SalomonBottomBarItem(
            icon: userPfp(
                path: budgetProvider.loadedUser.pfp,
                name: budgetProvider.loadedUser.userName,
                radius: 15),
            title: Text(budgetProvider.loadedUser.userName,
                style: TextStyle(
                    fontFamily: "Quick",
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: Theme.of(context).iconTheme.color)),
            selectedColor: Colors.grey.withOpacity(.5),
          ),
        ],
      );
    });
  });
}
