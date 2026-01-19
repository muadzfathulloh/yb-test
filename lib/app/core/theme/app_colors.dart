import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Primary Colors
  static const Color primary = Color(0xFF1877F2);
  static const Color primaryLight = Color(0xFF4A9FF5);
  static const Color primaryDark = Color(0xFF0D5DBF);

  // Background Colors
  static const Color background = Color(0xFFFFFFFF);
  static const Color backgroundLight = Color(0xFFF1F4FF);
  static const Color backgroundError = Color(0xFFFFF0F0);

  // Neutral Colors
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF1A1A1A);
  static const Color greyLight = Color(0xFFE0E0E0);
  static const Color greyMedium = Color(0xFF9E9E9E);
  static const Color greyDark = Color(0xFF616161);
  static const Color greyDarker = Color(0xFF424242);

  // Semantic Colors #
  static const Color green = Color(0xFF007D04);
  static const Color grey = Color(0xFF9E9E9E);
  static const Color error = Color(0xFFE53935);
  static const Color errorLight = Color(0xFFFDA29B);
  static const Color errorDark = Color(0xFFD92D20);

  static const Color success = Color(0xFF12B76A);
  static const Color successLight = Color(0xFF6CE9A6);
  static const Color successDark = Color(0xFF027A48);

  static const Color warning = Color(0xFFF79009);
  static const Color warningLight = Color(0xFFFEC84B);
  static const Color warningDark = Color(0xFFDC6803);

  static const Color info = Color(0xFF0BA5EC);
  static const Color infoLight = Color(0xFF7CD4FD);
  static const Color infoDark = Color(0xFF026AA2);

  // UI Specific
  static const Color accent = Color(0xFF1877F2);
  static const Color textHint = Color(0xFF9E9E9E);
  static const Color textSecondary = Color(0xFF9CA3AF);
  static const Color border = Color(0xFFE0E0E0);
  static const Color borderError = Color(0xFFF04438);
  static const Color borderFocus = Color(0xFF1F41BB);

  // Shadow Colors
  static Color shadowPrimary = primary.withOpacity(0.3);
  static Color shadowLight = Colors.black.withOpacity(0.1);
  static Color shadowMedium = Colors.black.withOpacity(0.2);
  static Color shadowDark = Colors.black.withOpacity(0.3);

  // Overlay Colors
  static Color overlay = Colors.black.withOpacity(0.5);
  static Color overlayLight = Colors.black.withOpacity(0.3);
}
