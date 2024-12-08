import 'package:budget/keys/types_keys.dart';
import 'package:budget/sheets/create_new_item.dart';
import 'package:budget/widgets/costume_icon_button.dart';
import 'package:budget/widgets/dashed_divider.dart';
import 'package:flutter/material.dart';

void showItemSectionSheet(BuildContext context, String parentClass) {
  showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        Color scaffoldColor = Theme.of(context).scaffoldBackgroundColor;
        return Container(
          padding: const EdgeInsets.all(30),
          decoration: BoxDecoration(
              color: scaffoldColor, borderRadius: BorderRadius.circular(15)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(Icons.close)),
                  const Text(
                    "  Chose a Type Of Item",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: "Quick",
                        fontSize: 16),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: dashedDivider(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  costumeIconButton(icon: Icons.receipt_rounded, title: bill, onTap: ()=> showNewItemSheet(context,bill, parentClass)),
                  costumeIconButton(icon: Icons.airplane_ticket, title: reservation, onTap: ()=> showNewItemSheet(context,reservation, parentClass)),
                  costumeIconButton(
                      icon: Icons.shopping_bag_rounded, title: purchase, onTap: ()=> showNewItemSheet(context,purchase, parentClass)),
                ],
              ),
            ],
          ),
        );
      });
}
