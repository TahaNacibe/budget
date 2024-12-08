int getCurrentSteps(
    {required double value, required double catValue, bool isProfile = false}) {
  if (catValue == 0) {
    // Prevent division by zero
    return 0;
  }
  if (value > catValue && !isProfile) {
    return 10;
  }

  // Calculate the percentage of the budget spent (clamped between 0 and 100%)
  double result =
      (value / catValue) * 10; // Since you have 10 steps in the progress bar
  // Ensure the result is in the range of 0 to 10
  if (result < 0) result = 0;
  if (result > 10) result = 10;
  return result.round(); // Return the rounded step value
}
