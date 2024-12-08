import 'package:budget/Screens/main_screen.dart';
import 'package:budget/providers/data_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  Future<void> _loadData() async {
    final budgetProvider = Provider.of<BudgetProvider>(context, listen: false);
    await budgetProvider.loadThemeState();
    await budgetProvider.loadUserData(context); // Load user data
    await budgetProvider.loadTransactionData(context); // Load transaction data
    await budgetProvider.loadInvestmentsList(context);
    await budgetProvider.loadPersonalList(context);
    await budgetProvider.loadRequiredList(context);
  }

  @override
  void initState() {
    _loadData().then((_) {
      Future.delayed(Duration(seconds: 1), () {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => MainScreen()));
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration:
              BoxDecoration(shape: BoxShape.circle, color: Colors.white),
          child: Image(image: AssetImage("assets/images/icon.png")),
        ),
      ),
    );
  }
}
