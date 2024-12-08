import 'package:flutter/material.dart';

Widget timeSinceLastTransaction({required String daysCount}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8), color: Colors.indigo),
          child: Text(
            daysCount,
            style: const TextStyle(
                fontFamily: "Quick",
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: Colors.white),
          ),
        ),
        const Text(
          "  days since last transaction",
          style: TextStyle(
              fontFamily: "Quick", fontWeight: FontWeight.w300, fontSize: 14),
        )
      ],
    ),
  );
}
