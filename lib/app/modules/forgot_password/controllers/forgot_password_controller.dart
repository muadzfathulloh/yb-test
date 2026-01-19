import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordController extends GetxController {
  // Text editing controller
  final emailController = TextEditingController();

  // Observable states
  final emailError = RxnString();

  @override
  void onInit() {
    super.onInit();

    // Add listener to validate on change
    emailController.addListener(() {
      if (emailError.value != null) {
        validateEmail();
      }
    });
  }

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }

  // Email validation
  bool validateEmail() {
    final email = emailController.text.trim();

    // Check if empty (required validation)
    if (email.isEmpty) {
      emailError.value = 'Email / Mobile number is required';
      return false;
    }

    // Email regex pattern
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    // Mobile regex pattern (simple: 10-15 digits)
    final mobileRegex = RegExp(r'^\d{10,15}$');

    if (!emailRegex.hasMatch(email) && !mobileRegex.hasMatch(email)) {
      emailError.value = 'Invalid Email or Mobile number';
      return false;
    }

    emailError.value = null;
    return true;
  }

  // Submit action
  void submit() {
    final isValid = validateEmail();

    if (isValid) {
      // Navigate to OTP verification with email/mobile
      Get.toNamed('/otp-verification', arguments: {'contact': emailController.text.trim()});
    }
  }
}
