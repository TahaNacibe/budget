import 'package:budget/dialogs/confirm_delete.dart';
import 'package:budget/models/shop_item.dart';
import 'package:budget/providers/data_provider.dart';
import 'package:budget/sheets/create_new_item.dart';
import 'package:budget/widgets/card_title_and_button.dart';
import 'package:budget/widgets/setting_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void showOptionsForItems(
    {required BuildContext context,
    required int? index,
    required ShopItem item}) {
  showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Consumer<BudgetProvider>(
            builder: (context, budgetProvider, child) {
              Color scaffoldColor = Theme.of(context).scaffoldBackgroundColor;
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                  color: scaffoldColor, borderRadius: BorderRadius.circular(25)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 12),
                    child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 2, horizontal: 12),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.grey.withOpacity(.1)),
                        child: cardTitle(title: "Items Options")),
                  ),
                  GestureDetector(
                    onTap: () {
                      if (index != null) {
                        budgetProvider.setItemUnpaidOrPaid(
                            item: item, index: index);
                        Navigator.pop(context);
                      }
                    },
                    child: settingItem(
                        title:
                            "Set ${item.name} as ${item.isPayed ? "UnPayed" : "Payed"}"),
                  ),
                  GestureDetector(
                    onTap: () async {
                      bool? answer =
                          await showDeleteConfirm(context, item.name);
                      if (answer != null) {
                        if (answer) {
                          if (index != null) {
                            budgetProvider.removeNewShopItem(
                                listKey: item.parentClass, index: index);
                            Navigator.pop(context);
                          }
                        }
                      }
                    },
                    child: settingItem(
                        title: "Remove ${item.name} from ${item.parentClass}"),
                  ),
                  GestureDetector(
                      onTap: () {
                        showNewItemSheet(context, item.type, item.parentClass,
                            index: index,
                            isEdit: true,
                            name: item.name,
                            item: item,
                            value: item.price.toString());
                      },
                      child: settingItem(title: "Edit ${item.name}")),
                  const SizedBox(
                    height: 5,
                  )
                ],
              ),
            ),
          );
        });
      });
}
