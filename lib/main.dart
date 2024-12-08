import 'package:budget/Screens/loading_screen.dart';
import 'package:budget/providers/data_provider.dart';
import 'package:budget/theme/theme_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => BudgetProvider()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Consumer<BudgetProvider>(builder: (context, budgetProvider, child) {
      return MaterialApp(
        theme: budgetProvider.isDarkTheme ? AppTheme.dark : AppTheme.light,
        debugShowCheckedModeBanner: false,
        home: const LoadingScreen(),
      );
    });
  }
}
