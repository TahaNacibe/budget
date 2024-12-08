import 'package:flutter/material.dart';

Widget costumeButton(
    {required String title, required bool isActive, required Color color}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      alignment: AlignmentDirectional.center,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: isActive ? color : Colors.grey.withOpacity(.9)),
      child: Text(
        title,
        style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: "Quick",
            color: Colors.white,
            fontSize: 18),
      ),
    ),
  );
}
