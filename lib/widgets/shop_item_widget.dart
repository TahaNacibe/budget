import 'package:budget/keys/types_keys.dart';
import 'package:budget/models/shop_item.dart';
import 'package:budget/providers/data_provider.dart';
import 'package:budget/services/amount_services.dart';
import 'package:budget/sheets/edit_item.dart';
import 'package:budget/widgets/dashed_divider.dart';
import 'package:budget/widgets/text_tag_widget.dart';
import 'package:flutter/material.dart';

Widget shopItemWidget(
    {required ShopItem item,
    required double catBalance,
    required int? index,
    int? searchIndex,
    required BudgetProvider budgetProvider}) {
  bool isAffordable = catBalance >= item.price;
  return Builder(builder: (context) {
    return GestureDetector(
      onTap: () {
        showOptionsForItems(context: context, index: index, item: item);
      },
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
        child: Column(
          children: [
            if (index != 0 && searchIndex != 0) dashedDivider(),
            Container(
                padding: const EdgeInsets.all(2),
                child: ListTile(
                  leading: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: Colors.indigo),
                    child: Icon(
                      item.type == bill
                          ? Icons.receipt_rounded
                          : item.type == reservation
                              ? Icons.airplane_ticket_rounded
                              : Icons.shopping_bag_rounded,
                      color: Colors.white,
                      size: 25,
                    ),
                  ),
                  title: Text(
                    item.name,
                    style: const TextStyle(
                        fontFamily: "Quick",
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                  subtitle: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "\$${formatNumber(item.price)}",
                        style: const TextStyle(
                            fontFamily: "Quick",
                            fontWeight: FontWeight.w400,
                            fontSize: 14),
                      ),
                      textTagWidget(
                          text: item.isPayed
                              ? "Already Payed"
                              : isAffordable
                                  ? "Affordable"
                                  : "Need ${formatNumber(item.price - catBalance)}",
                          color: item.isPayed
                              ? Colors.teal
                              : isAffordable
                                  ? Colors.indigo
                                  : Colors.orange)
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  });
}
