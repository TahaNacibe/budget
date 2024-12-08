import 'package:budget/Screens/settings/settings_page.dart';
import 'package:budget/models/shop_item.dart';
import 'package:budget/providers/data_provider.dart';
import 'package:budget/services/amount_services.dart';
import 'package:budget/services/get_steps.dart';
import 'package:budget/widgets/card_title_and_button.dart';
import 'package:budget/widgets/count_detail.dart';
import 'package:budget/widgets/user_pfp.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/statics_widget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  //* functions
  // get total entries for each category by a index (0 - all; 1 -invest; 2 - personal use; 3 -requirements)
  int getTotalEntries(
      {required List<ShopItem> invest,
      required List<ShopItem> person,
      required List<ShopItem> require,
      required int type}) {
    switch (type) {
      case 0:
        return invest.length + person.length + require.length;
      case 1:
        return invest.length;
      case 2:
        return person.length;
      case 3:
        return require.length;
      default:
        return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    Color scaffoldColor = Theme.of(context).scaffoldBackgroundColor;
    return Scaffold(
      backgroundColor: scaffoldColor,
      appBar: AppBar(
        backgroundColor: scaffoldColor,
        leading: IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SettingsPage()));
            },
            icon: const Icon(Icons.settings)),
      ),
      body: SingleChildScrollView(child: profileBody()),
    );
  }

  //* profile body
  Widget profileBody() {
    return Consumer<BudgetProvider>(builder: (context, budgetProvider, child) {
      return SizedBox(
        width: MediaQuery.sizeOf(context).width,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: Colors.grey.withOpacity(.7)),
              child: userPfp(
                  path: budgetProvider.loadedUser.pfp,
                  name: budgetProvider.loadedUser.userName,
                  radius: 70),
            ),
            const SizedBox(
              height: 15,
            ),
            //* user name
            Container(
              padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 12),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.grey.withOpacity(.1)),
              child: Text(
                budgetProvider.loadedUser.userName,
                style: TextStyle(
                    fontFamily: "Quick",
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
            ),

            //* statics
            staticsWidgetBody(budgetProvider: budgetProvider),
            itemsCount(budgetProvider: budgetProvider)
          ],
        ),
      );
    });
  }

  //* statics body
  Widget staticsWidgetBody({required BudgetProvider budgetProvider}) {
    //* vars
    double balance = budgetProvider.loadedUser.balance;
    double invest = budgetProvider.loadedUser.investBudget;
    double personal = budgetProvider.loadedUser.personalBudget;
    double requirements = budgetProvider.loadedUser.requireBudget;
    //* ui tree
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
          child: Container(
              padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 12),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.grey.withOpacity(.1)),
              child: cardTitle(title: "Balance Info")),
        ),
        staticsWidget(
            title: "Total Balance",
            value: " ${formatNumber(balance)}",
            max: 10,
            current: 10),
        staticsWidget(
            title: "Invested Balance",
            value: formatNumber(invest),
            max: 10,
            current: getCurrentSteps(
                value: invest, catValue: balance, isProfile: true)),
        staticsWidget(
            title: "Personal Balance",
            value: formatNumber(personal),
            max: 10,
            current: getCurrentSteps(
                value: personal, catValue: balance, isProfile: true)),
        staticsWidget(
            title: "Requirements Balance",
            value: formatNumber(requirements),
            max: 10,
            current: getCurrentSteps(
                value: requirements, catValue: balance, isProfile: true)),
      ],
    );
  }

  //* items counts
  Widget itemsCount({required BudgetProvider budgetProvider}) {
    List<ShopItem> invest = budgetProvider.loadedInvestList;
    List<ShopItem> person = budgetProvider.loadedPersonalList;
    List<ShopItem> require = budgetProvider.loadedRequiredList;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
          child: Container(
              padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 12),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.grey.withOpacity(.1)),
              child: cardTitle(title: "About Entries")),
        ),
        GridView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, childAspectRatio: 2),
          children: [
            countDetail(
                title: "Items",
                value: getTotalEntries(
                    invest: invest, person: person, require: require, type: 0)),
            countDetail(
                title: "Invested",
                value: getTotalEntries(
                    invest: invest, person: person, require: require, type: 1)),
            countDetail(
                title: "Personal Use",
                value: getTotalEntries(
                    invest: invest, person: person, require: require, type: 2)),
            countDetail(
                title: "required",
                value: getTotalEntries(
                    invest: invest, person: person, require: require, type: 3)),
          ],
        )
      ],
    );
  }
}
