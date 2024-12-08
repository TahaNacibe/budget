import 'package:budget/keys/types_keys.dart';
import 'package:budget/models/transaction.dart';
import 'package:budget/providers/data_provider.dart';
import 'package:budget/services/amount_services.dart';
import 'package:budget/sheets/new_deposit.dart';
import 'package:budget/widgets/app_bar.dart';
import 'package:budget/widgets/budget_cat.dart';
import 'package:budget/widgets/card_title_and_button.dart';
import 'package:budget/widgets/dashed_divider.dart';
import 'package:budget/widgets/time_since_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //* functions
  Future<void> addNewDeposit() async {
    showNewDepositSheet(context);
    // Add deposit logic here
  }

  //* Ui tree
  @override
  Widget build(BuildContext context) {
    Color scaffoldColor = Theme.of(context).scaffoldBackgroundColor;
    return Scaffold(
      backgroundColor: scaffoldColor,
      appBar: costumeAppBar(scaffoldColor),
      body: Consumer<BudgetProvider>(builder: (context, budgetProvider, child) {
        //* vars
        Transaction? lastAction = budgetProvider.loadedTransactions.lastOrNull;
        //* Ui tree
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            balanceWidget(budgetProvider, lastAction, scaffoldColor),
            titleOfSection(),
            Expanded(child: displayCatsBody(budgetProvider)),
          ],
        );
      }),
    );
  }

  //* balance widget with provider data
  Widget balanceWidget(
      BudgetProvider budgetProvider, Transaction? item, Color bg) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        mainInformationWidget(budgetProvider, item, bg),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
          child: IconButton(
              onPressed: () async {
                addNewDeposit();
              },
              icon: const Icon(Icons.add)),
        )
      ],
    );
  }

  //* main information widget with provider data
  Widget mainInformationWidget(
      BudgetProvider budgetProvider, Transaction? item, Color bg) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: bg,
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(.1),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(0, 2))
            ]),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  cardTitle(title: "Your Balance"),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      "\$${formatNumber(budgetProvider.loadedUser.balance)}",
                      maxLines: 1,
                      overflow:
                          TextOverflow.ellipsis, // Hides overflow with ellipsis
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 32),
                    ),
                  ),
                  dashedDivider(),
                  timeSinceLastTransaction(
                      daysCount:
                          "${item != null ? DateTime.now().difference(item.timestamp).inDays : 0}")
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  //* title widget
  Widget titleOfSection() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 2, 4, 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Current Budget",
            style: TextStyle(
                fontFamily: "Quick", fontWeight: FontWeight.bold, fontSize: 16),
          ),
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.keyboard_arrow_down_rounded,
                color: Colors.grey.withOpacity(.8),
                size: 20,
              ))
        ],
      ),
    );
  }

  //* data body

  Widget displayCatsBody(BudgetProvider budgetProvider) {
    return DefaultTabController(
      length: 3, // Number of tabs
      child: Column(
        children: [
          // TabBar at the top
          TabBar(
            labelColor: Colors.indigo, // Active tab text color
            unselectedLabelColor: Colors.grey, // Inactive tab text color
            dividerColor: Colors.grey.withOpacity(.3),
            indicatorColor: Colors.indigo, // Underline indicator color
            tabs: [
              Tab(child: cardTitle(title: "Investment")),
              Tab(child: cardTitle(title: 'Personal use')),
              Tab(child: cardTitle(title: 'Required')),
            ],
          ),

          // The view for each tab
          Expanded(
            child: TabBarView(
              children: [
                budgetCategory(
                  name: "Investment",
                  budgetProvider: budgetProvider,
                  catKey: investments,
                  icon: Icons.attach_money_sharp,
                  value: budgetProvider.loadedUser.investBudget,
                  currentBalance: budgetProvider.loadedUser.balance,
                  shoppingList: budgetProvider.loadedInvestList,
                ),
                budgetCategory(
                  name: "Personal use",
                  budgetProvider: budgetProvider,
                  catKey: personalUse,
                  icon: Icons.person_2_rounded,
                  value: budgetProvider.loadedUser.personalBudget,
                  currentBalance: budgetProvider.loadedUser.balance,
                  shoppingList: budgetProvider.loadedPersonalList,
                ),
                budgetCategory(
                  name: "Requirements",
                  budgetProvider: budgetProvider,
                  catKey: requirements,
                  icon: Icons.api_rounded,
                  value: budgetProvider.loadedUser.requireBudget,
                  currentBalance: budgetProvider.loadedUser.balance,
                  shoppingList: budgetProvider.loadedRequiredList,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
