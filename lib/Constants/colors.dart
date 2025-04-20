import 'package:flutter/material.dart';

class AppColors {
  // Primary colors
  static const Color primaryDark = Color.fromARGB(255, 3, 37, 65);
  static const Color primaryBlue = Colors.lightBlue;
  static const Color accentRed = Colors.red;

  // Background colors
  static const Color background = Colors.grey;
  static const Color cardBackground = Colors.white;

  // Text colors
  static const Color textDark = Colors.blueGrey;
  static const Color textPrimary = Colors.black87;
  static const Color textSecondary = Colors.grey;
  static const Color textLight = Colors.white;

  // Status colors
  static const Color error = Colors.red;
  static const Color success = Colors.green;
  static const Color warning = Colors.amber;
  static const Color info = Colors.blue;

  // Rating color
  static const Color ratingAmber = Colors.amber;

  // Grey color - use with opacity
  static const Color grey = Colors.grey;

  // Shadow colors
  static final Color shadowColor = Colors.black.withOpacity(0.1);
  static final Color shadowColorLight = Colors.black.withOpacity(0.05);

  // Shimmer colors
  static const Color shimmerBase = Colors.grey;
  static const Color shimmerHighlight = Colors.white70;

  // Gradient colors
  static final List<Color> splashGradient = [
    primaryDark,
    Colors.blueGrey,
  ];

  static final List<Color> posterGradient = [
    Colors.transparent,
    Colors.black.withOpacity(0.8),
  ];
}
