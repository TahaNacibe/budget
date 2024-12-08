import 'package:budget/widgets/costume_button.dart';
import 'package:flutter/material.dart';

Future<bool?> showConfirmLoad(BuildContext context) {
  // Return the result of the showModalBottomSheet as a Future<bool?>
  return showModalBottomSheet<bool>(
    context: context,
    backgroundColor: Colors.transparent,
    builder: (context) {
      Color scaffoldColor = Theme.of(context).scaffoldBackgroundColor;
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: scaffoldColor,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Confirm Action',
                style: TextStyle(
                  fontFamily: "Quick",
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 10),
              Column(
                mainAxisSize: MainAxisSize.min, // Adjusts the dialog height
                children: [
                  const Text(
                    'All current Data will be lost, are you sure you want to continue?',
                    style: TextStyle(
                      fontFamily: "Quick",
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(
                      height: 20), // Add space between text and buttons
                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceBetween, // Space between buttons
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context)
                                .pop(false); // Return 'false' for Cancel
                          },
                          child: costumeButton(
                            title: "Cancel",
                            isActive: true,
                            color: Colors.grey.withOpacity(.5),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10), // Space between buttons
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context)
                                .pop(true); // Return 'true' for Confirm
                          },
                          child: costumeButton(
                            title: "Load",
                            isActive: true,
                            color: Colors.red.withOpacity(.7),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}
