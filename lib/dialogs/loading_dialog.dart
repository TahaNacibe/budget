import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class CostumeLoadingDialog extends StatefulWidget {
  const CostumeLoadingDialog({super.key});

  @override
  State<CostumeLoadingDialog> createState() => _CostumeLoadingDialogState();
}

class _CostumeLoadingDialogState extends State<CostumeLoadingDialog> {
  Color _currentColor =
      Colors.blue; // Initial color for CircularProgressIndicator
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startColorChange();
  }

  @override
  void dispose() {
    _timer?.cancel(); // Stop the timer when the dialog is disposed
    super.dispose();
  }

  void _startColorChange() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _currentColor = _generateRandomColor();
      });
    });
  }

  Color _generateRandomColor() {
    Random random = Random();
    return Color.fromARGB(
      255,
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Get the current text/icon color from the theme
    final Color baseColor = Theme.of(context).scaffoldBackgroundColor;

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      backgroundColor:
          baseColor.withOpacity(0.8), // Background color with opacity
      child: Padding(
        padding:
            const EdgeInsets.all(16.0), // Adjusted padding for a smaller box
        child: SizedBox(
          height: 80, // Small square box with 80x80 dimensions
          width: 80,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                      _currentColor.withOpacity(.5)), // Change color randomly
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text("Working On It",
                    style: TextStyle(
                        fontFamily: "Quick",
                        fontWeight: FontWeight.bold,
                        fontSize: 16))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Function to show the custom dialog
void showCustomProgressDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible:
        false, // Prevent dismissing the dialog by tapping outside
    builder: (BuildContext context) {
      return const CostumeLoadingDialog();
    },
  );
}
