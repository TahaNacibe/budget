import 'package:budget/keys/types_keys.dart';
import 'package:budget/sheets/new_action.dart';
import 'package:budget/widgets/costume_icon_button.dart';
import 'package:budget/widgets/dashed_divider.dart';
import 'package:flutter/material.dart';

void showTypeSectionSheet(BuildContext context) {
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
                    "  Chose a Type For Transaction",
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
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  costumeIconButton(
                      icon: Icons.attach_money_sharp,
                      title: investments,
                      onTap: () => showNewActionSheet(context, investments)),
                  costumeIconButton(
                      icon: Icons.person_2_rounded,
                      title: personalUse,
                      onTap: () => showNewActionSheet(context, personalUse)),
                  costumeIconButton(
                      icon: Icons.api,
                      title: requirements,
                      onTap: () => showNewActionSheet(context, requirements)),
                ],
              ),
            ],
          ),
        );
      });
}
