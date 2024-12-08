import 'package:flutter/material.dart';

Widget cardTitle({required String title}) {
  return Builder(builder: (context) {
    return Text(
      title,
      style: const TextStyle(
          fontFamily: "Quick", fontWeight: FontWeight.bold, fontSize: 16),
    );
  });
}
