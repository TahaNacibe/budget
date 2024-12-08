import 'package:budget/Screens/history_page.dart';
import 'package:budget/Screens/home_page.dart';
import 'package:budget/Screens/profile_page.dart';
import 'package:budget/Screens/search_page.dart';
import 'package:budget/widgets/nav_bar.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  //* global index
  int pageIndex = 0;
  //* list of pages
  List<Widget> pages = [
    const HomePage(),
    const HistoryPage(),
    const SearchPage(),
    const ProfilePage()
  ];




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: costumeNavBar(((index) {
        setState(() {
          pageIndex = index;
        });
      })),
      body: pages[pageIndex],
    );
  }
}
