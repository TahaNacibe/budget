import 'package:dotted_dashed_line/dotted_dashed_line.dart';
import 'package:flutter/material.dart';

Widget dashedDivider() {
  return const Padding(
    padding: EdgeInsets.all(8.0),
    child: DottedDashedLine(
      height: 0,
      width: 300,
      axis: Axis.horizontal,
      dashColor: Colors.grey,
    ),
  );
}
