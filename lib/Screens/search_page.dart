import 'package:budget/keys/types_keys.dart';
import 'package:budget/models/shop_item.dart';
import 'package:budget/models/transaction.dart';
import 'package:budget/providers/data_provider.dart';
import 'package:budget/widgets/costume_text_filed.dart';
import 'package:budget/widgets/empty_widget.dart';
import 'package:budget/widgets/shop_item_widget.dart';
import 'package:budget/widgets/transection_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  bool isSearching = false;
  bool isLoading = false;

  final TextEditingController _searchController = TextEditingController();

  Map<String, dynamic> searchResult({
    required String searchTerm,
    required BudgetProvider budgetCategory,
  }) {
    List<ShopItem> shopItems = [];
    List<Transaction> transactions = [];

    // Get all shop items in the user
    shopItems.addAll(budgetCategory.loadedInvestList);
    shopItems.addAll(budgetCategory.loadedPersonalList);
    shopItems.addAll(budgetCategory.loadedRequiredList);

    // Get transaction history
    transactions = budgetCategory.loadedTransactions;
    //*
    Map<String, dynamic> result = {
      "shopItems": shopItems
          .where((e) =>
              e.name
                  .toString()
                  .toLowerCase()
                  .contains(searchTerm.toLowerCase()) ||
              e.price.toString().contains(searchTerm.trim()))
          .toList(),
      "transaction": transactions
          .where((e) => e.value.toString().contains(searchTerm))
          .toList(),
    };
    isLoading = false;
    return result;
  }

  int? getItemIndex({
    required ShopItem item,
    required BudgetProvider budgetProvider,
  }) {
    switch (item.parentClass) {
      case investments:
        return budgetProvider.loadedInvestList.indexOf(item);
      case personalUse:
        return budgetProvider.loadedPersonalList.indexOf(item);
      case requirements:
        return budgetProvider.loadedRequiredList.indexOf(item);
      default:
        return null;
    }
  }

  double getCatValue({
    required String catKey,
    required BudgetProvider budgetProvider,
  }) {
    switch (catKey) {
      case investments:
        return budgetProvider.loadedUser.investBudget;
      case personalUse:
        return budgetProvider.loadedUser.personalBudget;
      case requirements:
        return budgetProvider.loadedUser.requireBudget;
      default:
        return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    Color scaffoldColor = Theme.of(context).scaffoldBackgroundColor;
    return Scaffold(
      backgroundColor: scaffoldColor,
      // appBar: ,
      body: Consumer<BudgetProvider>(
        builder: (context, budgetProvider, child) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 40.0),
                child: costumeAppBar(),
              ),
              searchResultWidget(
                budgetProvider: budgetProvider,
                searchResult: searchResult(
                  searchTerm: _searchController.text,
                  budgetCategory: budgetProvider,
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  PreferredSizeWidget costumeAppBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(70),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: costumeTextFiled(
          controller: _searchController,
          hint: "Transaction, Shop Item, ...",
          isOnlyNumbers: false,
          isAdd: null,
          trailing: IconButton(
            onPressed: () {
              if (isSearching) {
                setState(() {
                  isSearching = false;
                  _searchController.clear();
                });
              }
            },
            icon: Icon(isSearching ? Icons.close : Icons.search),
          ),
          onChangeAccrue: (searchedTerm) {
            setState(() {
              isSearching = _searchController.text.isNotEmpty;
              isLoading = isSearching; // Only set loading if searching
            });
          },
        ),
      ),
    );
  }

  Widget searchResultWidget({
    required Map<String, dynamic> searchResult,
    required BudgetProvider budgetProvider,
  }) {
    List<ShopItem> shopItemSearch = searchResult["shopItems"];
    List<Transaction> transactionsSearch = searchResult["transaction"];

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: isSearching
          ? isLoading
              ? const Center(child: CircularProgressIndicator())
              : ListView(
                  shrinkWrap: true,
                  children: [
                    shopItemsSearchResult(
                      items: shopItemSearch,
                      budgetProvider: budgetProvider,
                    ),
                    transactionSearchWidget(
                      transactionsSearch: transactionsSearch,
                    ),
                  ],
                )
          : Center(child: emptyScreen()),
    );
  }

  Widget catTitle({required String title}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Text(
        title,
        style: const TextStyle(
          fontFamily: "Quick",
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
    );
  }

  Widget shopItemsSearchResult({
    required List<ShopItem> items,
    required BudgetProvider budgetProvider,
  }) {
    return items.isNotEmpty
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              catTitle(title: "Items"),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: items.length,
                itemBuilder: (context, index) {
                  ShopItem item = items[index];
                  return shopItemWidget(
                    item: item,
                    searchIndex: index,
                    catBalance: getCatValue(
                      catKey: item.parentClass,
                      budgetProvider: budgetProvider,
                    ),
                    index: getItemIndex(
                      item: item,
                      budgetProvider: budgetProvider,
                    ),
                    budgetProvider: budgetProvider,
                  );
                },
              ),
            ],
          )
        : const SizedBox.shrink();
  }

  Widget transactionSearchWidget({
    required List<Transaction> transactionsSearch,
  }) {
    return transactionsSearch.isNotEmpty
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              catTitle(title: "Transactions"),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: transactionsSearch.length,
                itemBuilder: (context, index) {
                  Transaction item = transactionsSearch[index];
                  return transactionItem(item: item, index: index);
                },
              ),
            ],
          )
        : const SizedBox.shrink();
  }
}
