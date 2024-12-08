import 'package:flutter/material.dart';

Widget emptyScreen() {
  return const Padding(
    padding: EdgeInsets.only(top: 20.0),
    child: Text(
      "Nothing here to show\n(0~0)!",
      textAlign: TextAlign.center,
      style: TextStyle(
        fontFamily: "Quick",
        fontWeight: FontWeight.bold,
        fontSize: 25,
      ),
    ),
  );
}
