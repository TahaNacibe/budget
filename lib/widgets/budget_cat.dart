import 'package:budget/models/shop_item.dart';
import 'package:budget/providers/data_provider.dart';
import 'package:budget/services/amount_services.dart';
import 'package:budget/services/get_steps.dart';
import 'package:budget/sheets/new_item_sheet.dart';
import 'package:budget/widgets/card_title_and_button.dart';
import 'package:budget/widgets/empty_widget.dart';
import 'package:budget/widgets/shop_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

//* section widget
Widget budgetCategory({
  required String name,
  required double value,
  required BudgetProvider budgetProvider,
  required String catKey,
  required IconData icon,
  required List<ShopItem> shoppingList,
  required double currentBalance,
}) {
  int valueAsInt = getCurrentSteps(
      value: value, catValue: budgetProvider.loadedUser.balance);
  return Builder(builder: (context) {
    Color scaffoldColor = Theme.of(context).scaffoldBackgroundColor;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 6),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: scaffoldColor,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      cardTitle(title: name),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        child: Text(
                          "\$${formatNumber(value)}",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 25),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      icon,
                      size: 30,
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: StepProgressIndicator(
                    roundedEdges: const Radius.circular(15),
                    currentStep: valueAsInt,
                    padding: 0,
                    unselectedColor: Colors.grey.withOpacity(.3),
                    selectedColor: value < 0
                        ? Colors.red
                        : value == 0
                            ? Colors.black
                            : value < 100
                                ? Colors.orange
                                : Colors.green,
                    totalSteps: 10),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: scaffoldColor,
                    border: Border.all(
                        color: Colors.grey.withOpacity(.3), width: .5)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "$name Purchases: ",
                      style: const TextStyle(
                          fontFamily: "Quick",
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                    IconButton(
                        onPressed: () {
                          showItemSectionSheet(context, catKey);
                        },
                        icon: const Icon(Icons.add))
                  ],
                ),
              ),
              if (shoppingList.isNotEmpty)
                ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: shoppingList.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      ShopItem item = shoppingList[index];
                      return shopItemWidget(
                          budgetProvider: budgetProvider,
                          item: item,
                          catBalance: value,
                          index: index);
                    }),
              if (shoppingList.isEmpty) Center(child: emptyScreen())
            ],
          ),
        ),
      ),
    );
  });
}


/*
import 'package:budget/services/amount_services.dart';
import 'package:budget/widgets/card_title_and_button.dart';
import 'package:budget/widgets/dashed_divider.dart';
import 'package:flutter/material.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

//* section widget
Widget budgetCategory(
    {required String name,
    required double value,
    required double currentBalance,
    required String desc}) {
  int valueAsInt = value.toInt();
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
    child: Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(.2),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, 2))
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          cardTitle(title: name),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Text(
              "\$${formatNumber(value)}",
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
          ),
          dashedDivider(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              desc,
              style: const TextStyle(
                  fontWeight: FontWeight.w300,
                  fontFamily: "Quick",
                  fontSize: 12),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: StepProgressIndicator(
                roundedEdges: const Radius.circular(15),
                currentStep: valueAsInt,
                padding: 0,
                unselectedColor: Colors.grey.withOpacity(.3),
                selectedColor: valueAsInt < 0
                    ? Colors.red
                    : valueAsInt == 0
                        ? Colors.black
                        : valueAsInt < 100
                            ? Colors.orange
                            : Colors.green,
                totalSteps: currentBalance.toInt()),
          ),
        ],
      ),
    ),
  );
}
 */*/