String formatNumber(double value) {
  // Save the sign of the value to apply it after formatting
  bool isNegative = value < 0;

  // Work with the absolute value for formatting
  value = value.abs();

  String formattedValue;

  if (value >= 1e18) {
    // If the value is 1 quintillion or more, format it with 'Qi'
    formattedValue = (value / 1e18).toStringAsFixed(2) + 'Qi';
  } else if (value >= 1e15) {
    // If the value is 1 quadrillion or more, format it with 'Q'
    formattedValue = (value / 1e15).toStringAsFixed(2) + 'Q';
  } else if (value >= 1e12) {
    // If the value is 1 trillion or more, format it with 'T'
    formattedValue = (value / 1e12).toStringAsFixed(2) + 'T';
  } else if (value >= 1e9) {
    // If the value is 1 billion or more, format it with 'B'
    formattedValue = (value / 1e9).toStringAsFixed(2) + 'B';
  } else if (value >= 1e6) {
    // If the value is 1 million or more, format it with 'M'
    formattedValue = (value / 1e6).toStringAsFixed(2) + 'M';
  } else if (value >= 1e3) {
    // If the value is 1 thousand or more, format it with comma separation
    formattedValue = value
        .toStringAsFixed(0)
        .replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (match) => ',');
  } else {
    // If the value is below 1 thousand, return it as-is with 2 decimal places
    formattedValue = value.toStringAsFixed(2);
  }

  // If the original number was negative, apply the negative sign
  if (isNegative) {
    formattedValue = '-' + formattedValue;
  }

  return formattedValue;
}
