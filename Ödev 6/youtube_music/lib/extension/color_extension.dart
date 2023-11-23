import 'package:flutter/material.dart';

extension ColorExtension on Color {
  Color getLighterColor() {
    // Get the background color's red, green, and blue values
    int red = this.red;
    int green = this.green;
    int blue = this.blue;

    // Calculate the lighter shade by reducing darkness (for example, by adding 20 to each color)
    int lighterRed = (red + 30).clamp(
        0, 255); // Ensure the value stays within the valid range (0 - 255)
    int lighterGreen = (green + 30).clamp(0, 255);
    int lighterBlue = (blue + 30).clamp(0, 255);

    // Return the new color with increased brightness
    return Color.fromRGBO(lighterRed, lighterGreen, lighterBlue, 1.0);
  }
}
