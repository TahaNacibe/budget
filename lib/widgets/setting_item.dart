import 'package:flutter/material.dart';

Widget settingItem(
    {required String title,
    Widget leading = const SizedBox.shrink(),
    Widget trailing = const Icon(Icons.arrow_forward_ios_rounded),
    String? hint}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
    child: ListTile(
      title: Text(title,
          style: const TextStyle(
              fontFamily: "Quick", fontWeight: FontWeight.bold, fontSize: 18)),
      subtitle: hint != null
          ? Text(hint,
              style: const TextStyle(
                  fontFamily: "Quick",
                  fontWeight: FontWeight.w400,
                  fontSize: 14))
          : null,
      trailing: trailing,
    ),
  );
}
