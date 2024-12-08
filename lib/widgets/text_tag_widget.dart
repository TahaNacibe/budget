import 'package:flutter/material.dart';

Widget textTagWidget({required String text, required Color color}) {
  return Container(
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color, width: .5)),
      child: Text(
        text,
        style: TextStyle(
            color: color,
            fontFamily: "Quick",
            fontWeight: FontWeight.w400,
            fontSize: 14),
      ));
}
