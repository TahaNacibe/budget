import 'dart:ui';

import 'package:budget/models/transaction.dart';
import 'package:budget/services/amount_services.dart';
import 'package:budget/services/time_services.dart';
import 'package:budget/services/transections_services.dart';
import 'package:budget/widgets/dashed_divider.dart';
import 'package:budget/widgets/text_tag_widget.dart';
import 'package:flutter/material.dart';

Widget transactionItem({required Transaction item, required int index}) {
  int? expandedIndex;

  return StatefulBuilder(builder: (context, setState) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
      child: Column(
        children: [
          ListTile(
            leading: IconButton(
                onPressed: () {
                  setState(() {
                    expandedIndex == index
                        ? expandedIndex = null
                        : expandedIndex = index;
                  });
                },
                icon: const Icon(Icons.keyboard_arrow_down_rounded)),
            onTap: () {
              setState(() {
                expandedIndex == index
                    ? expandedIndex = null
                    : expandedIndex = index;
              });
            },
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "\$${formatNumber(item.value)}",
                  style: const TextStyle(
                      fontFamily: "Quick",
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
                textTagWidget(
                    text: item.isWithdraw ? "Withdraw" : "Deposit",
                    color: item.isWithdraw ? Colors.red : Colors.indigo),
              ],
            ),
            subtitle: Text(
              formatDateTime(item.timestamp),
              style: const TextStyle(
                  fontFamily: "Quick",
                  fontWeight: FontWeight.w400,
                  fontSize: 14),
            ),
          ),
          AnimatedContainer(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 40),
            height:
                expandedIndex == null ? 0 : (expandedIndex != index ? 0 : 140),
            duration: const Duration(milliseconds: 200),
            child: Text(
              formatTransactionInfo(item),
              style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontFamily: "Quick",
                  fontSize: 16),
            ),
          ),
          dashedDivider()
        ],
      ),
    );
  });
}
