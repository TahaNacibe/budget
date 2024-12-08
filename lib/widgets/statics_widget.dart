import 'package:budget/widgets/dashed_divider.dart';
import 'package:flutter/material.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

Widget staticsWidget(
    {required String title,
    required String value,
    required int max,
    required int current}) {
  return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 12),
      child: Column(
        children: [
          ListTile(
            title: Text(
              title,
              style: const TextStyle(
                  fontFamily: "Quick",
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
            subtitle: Text(
              "\$$value",
              style: const TextStyle(
                  fontFamily: "Quick",
                  fontWeight: FontWeight.w400,
                  fontSize: 14),
            ),
            trailing: SizedBox(
              height: 50,
              width: 50,
              child: CircularStepProgressIndicator(
                  unselectedColor: Colors.grey.withOpacity(.3),
                  selectedColor: Colors.indigo,
                  currentStep: current,
                  padding: 0,
                  totalSteps: max),
            ),
          ),
          dashedDivider()
        ],
      ));
}
