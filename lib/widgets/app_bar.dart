import 'package:budget/services/time_services.dart';
import 'package:flutter/material.dart';

PreferredSizeWidget costumeAppBar(Color color) {
  return AppBar(
    backgroundColor: color,
    title: Text(
      formatDateTime(DateTime.now()),
      style: const TextStyle(
          fontFamily: "Quick", fontWeight: FontWeight.w400, fontSize: 20),
    ),
  );
}
