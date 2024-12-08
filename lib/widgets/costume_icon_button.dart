import 'package:flutter/material.dart';

Widget costumeIconButton({required IconData icon, required String title, required VoidCallback onTap}) {
  return Builder(builder: (context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.grey.withOpacity(.2)),
            child: Icon(
              icon,
              size: 30,
            ),
          ),
        ),
        Text(
          title,
          style: const TextStyle(
              fontWeight: FontWeight.w300, fontFamily: "Quick", fontSize: 14),
        )
      ],
    );
  });
}
