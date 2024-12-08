import 'package:flutter/material.dart';

Widget countDetail({required String title, required int value}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.grey.withOpacity(.4), width: .5)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: const TextStyle(
                fontFamily: "Quick", fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Text(
            value.toString(),
            style: const TextStyle(
                fontFamily: "Quick", fontWeight: FontWeight.w400, fontSize: 20),
          )
        ],
      ),
    ),
  );
}
