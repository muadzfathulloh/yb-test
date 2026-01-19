import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme/app_colors.dart';

enum AppButtonVariant { primary, outlined }

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final AppButtonVariant variant;
  final double? width;
  final double height;
  final bool isLoading;

  const AppButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.variant = AppButtonVariant.primary,
    this.width,
    this.height = 60,
    this.isLoading = false,
  });

  // Primary button factory
  factory AppButton.primary({
    required String text,
    required VoidCallback onPressed,
    double? width,
    double height = 60,
    bool isLoading = false,
  }) {
    return AppButton(
      text: text,
      onPressed: onPressed,
      variant: AppButtonVariant.primary,
      width: width,
      height: height,
      isLoading: isLoading,
    );
  }

  // Outlined button factory
  factory AppButton.outlined({
    required String text,
    required VoidCallback onPressed,
    double? width,
    double height = 60,
    bool isLoading = false,
  }) {
    return AppButton(
      text: text,
      onPressed: onPressed,
      variant: AppButtonVariant.outlined,
      width: width,
      height: height,
      isLoading: isLoading,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isPrimary = variant == AppButtonVariant.primary;

    return SizedBox(
      width: width ?? double.infinity,
      height: height,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: isPrimary ? AppColors.primary : AppColors.white,
          foregroundColor: isPrimary ? AppColors.white : AppColors.primary,
          side: isPrimary ? null : BorderSide(color: AppColors.primary, width: 2),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          elevation: isPrimary ? 10 : 0,
          shadowColor: isPrimary ? AppColors.shadowPrimary : null,
        ),
        child: isLoading
            ? SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    isPrimary ? AppColors.white : AppColors.primary,
                  ),
                ),
              )
            : Text(text, style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold)),
      ),
    );
  }
}
