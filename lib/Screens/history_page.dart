import 'package:budget/models/transaction.dart';
import 'package:budget/providers/data_provider.dart';
import 'package:budget/sheets/filter_sheet.dart';
import 'package:budget/widgets/transection_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  //* vars
  int? expandedIndex;
  int displayIndex = 0;
  bool descended = true;

  //* Ui tree
  @override
  Widget build(BuildContext context) {
    return Consumer<BudgetProvider>(builder: (context, budgetProvider, child) {
      Color scaffoldColor = Theme.of(context).scaffoldBackgroundColor;
      return Scaffold(
          backgroundColor: scaffoldColor,
          appBar: AppBar(
            backgroundColor: scaffoldColor,
            title: Text(
              "Total Of ${budgetProvider.loadedTransactions.length} Transaction",
              style: const TextStyle(
                  fontFamily: "Quick",
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    showFilterBottomSheet(context, displayIndex, descended,
                        (ind) {
                      setState(() {
                        displayIndex = ind;
                      });
                    }, (state) {
                      setState(() {
                        descended = state;
                      });
                    });
                  },
                  icon: const Icon(Icons.menu_rounded))
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(12),
                  child: Text(
                    "All Transaction will be recorded here, all records contain amount and date and type of transaction and it will be ordered by newest",
                    style: TextStyle(
                        fontFamily: "Quick",
                        fontWeight: FontWeight.w400,
                        fontSize: 14),
                  ),
                ),
                ListView.builder(
                    shrinkWrap: true,
                    reverse: descended,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: budgetProvider.loadedTransactions.length,
                    itemBuilder: (context, index) {
                      Transaction item =
                          budgetProvider.loadedTransactions[index];
                      return Visibility(
                        visible: displayIndex == 0 ||
                            displayIndex == 1 && !item.isWithdraw ||
                            displayIndex == 2 && item.isWithdraw,
                        child: transactionItem(item: item, index: index),
                      );
                    })
              ],
            ),
          ));
    });
  }
}
