import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';

class ResetPasswordController extends GetxController {
  // Text editing controllers
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // Observable states
  final newPasswordError = RxnString();
  final confirmPasswordError = RxnString();

  @override
  void onInit() {
    super.onInit();

    // Add listeners to validate on change
    newPasswordController.addListener(() {
      if (newPasswordError.value != null) {
        validateNewPassword();
      }
    });

    confirmPasswordController.addListener(() {
      if (confirmPasswordError.value != null) {
        validateConfirmPassword();
      }
    });
  }

  @override
  void onClose() {
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }

  // New password validation
  bool validateNewPassword() {
    final password = newPasswordController.text;

    // Check if empty (required validation)
    if (password.isEmpty) {
      newPasswordError.value = 'New Password is required';
      return false;
    }

    // Min length 8
    if (password.length < 8) {
      newPasswordError.value = 'Password must be at least 8 characters';
      return false;
    }

    // Alphanumeric check
    final hasLetter = password.contains(RegExp(r'[a-zA-Z]'));
    final hasNumber = password.contains(RegExp(r'[0-9]'));
    if (!hasLetter || !hasNumber) {
      newPasswordError.value = 'Password must be alphanumeric (letters and numbers)';
      return false;
    }

    newPasswordError.value = null;
    return true;
  }

  // Confirm password validation
  bool validateConfirmPassword() {
    final newPassword = newPasswordController.text;
    final confirmPassword = confirmPasswordController.text;

    // Check if empty (required validation)
    if (confirmPassword.isEmpty) {
      confirmPasswordError.value = 'Confirm Password is required';
      return false;
    }

    // Check if passwords match
    if (newPassword != confirmPassword) {
      confirmPasswordError.value = 'Passwords do not match';
      return false;
    }

    confirmPasswordError.value = null;
    return true;
  }

  // Submit action
  void submit() {
    final isNewPasswordValid = validateNewPassword();
    final isConfirmPasswordValid = validateConfirmPassword();

    if (isNewPasswordValid && isConfirmPasswordValid) {
      // TODO: Implement actual password reset logic

      // Show success message
      Get.snackbar(
        'Success',
        'Password has been reset successfully',
        backgroundColor: AppColors.primary.withOpacity(0.1),
        colorText: AppColors.primary,
        duration: const Duration(seconds: 2),
      );

      // Navigate back to login
      Get.offAllNamed('/login');
    }
  }
}
