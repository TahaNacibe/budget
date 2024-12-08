import 'dart:io';
import 'package:flutter/material.dart';

// Function to create a circular profile picture widget
Widget userPfp(
    {required String path, required String? name, required double radius}) {
  return ClipOval(
    child: Container(
      width: radius * 2, // Set both width and height equal for a perfect circle
      height: radius * 2,
      child: Image.file(
        File(path),
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            width: radius * 2, // Same width for circular shape
            height: radius * 2, // Same height for circular shape
            color: Colors.indigo, // Default color if image fails to load
            alignment: Alignment.center,
            child: Text(
              (name ?? "User")[0]
                  .toUpperCase(), // Display the first letter of the name
              style: TextStyle(
                fontSize: radius, // Font size relative to radius
                color: Colors.white, // Text color
                fontWeight: FontWeight.bold, // Bold text
              ),
            ),
          );
        },
      ),
    ),
  );
}
