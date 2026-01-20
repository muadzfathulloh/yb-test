import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {
  // Text editing controllers
  final emailController = TextEditingController();
  final emailConfirmationController = TextEditingController();
  final passwordController = TextEditingController();

  // Observable states
  final emailError = RxnString();
  final emailConfirmationError = RxnString();
  final passwordError = RxnString();
  final isPasswordVisible = false.obs;
  final rememberMe = true.obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    emailController.addListener(_emailListener);
    emailConfirmationController.addListener(_emailConfirmationListener);
  }

  void _emailListener() {
    if (emailError.value != null) {
      validateEmail();
    }
    if (emailConfirmationError.value != null && emailConfirmationController.text.isNotEmpty) {
      validateEmailConfirmation();
    }
  }

  void _emailConfirmationListener() {
    if (emailConfirmationError.value != null) {
      validateEmailConfirmation();
    }
  }

  @override
  void onClose() {
    emailController.removeListener(_emailListener);
    emailConfirmationController.removeListener(_emailConfirmationListener);
    super.onClose();
  }

  // Email validation
  bool validateEmail() {
    final email = emailController.text.trim();

    // Check if empty (required validation)
    if (email.isEmpty) {
      emailError.value = 'Email is required';
      return false;
    }

    // Email regex pattern
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(email)) {
      emailError.value = 'Invalid Email';
      return false;
    }

    emailError.value = null;
    return true;
  }

  // Email confirmation validation
  bool validateEmailConfirmation() {
    final email = emailController.text.trim();
    final emailConfirmation = emailConfirmationController.text.trim();

    // Check if empty (required validation)
    if (emailConfirmation.isEmpty) {
      emailConfirmationError.value = 'Email Confirmation is required';
      return false;
    }

    // Check if emails match
    if (email != emailConfirmation) {
      emailConfirmationError.value = 'Email does not match';
      return false;
    }

    emailConfirmationError.value = null;
    return true;
  }

  // Password validation
  bool validatePassword() {
    final password = passwordController.text;

    // Check if empty (required validation)
    if (password.isEmpty) {
      passwordError.value = 'Password is required';
      return false;
    }

    // Min length 8
    if (password.length < 8) {
      passwordError.value = 'Password must be at least 8 characters';
      return false;
    }

    // Alphanumeric check
    final hasLetter = password.contains(RegExp(r'[a-zA-Z]'));
    final hasNumber = password.contains(RegExp(r'[0-9]'));
    if (!hasLetter || !hasNumber) {
      passwordError.value = 'Password must be alphanumeric (letters and numbers)';
      return false;
    }

    passwordError.value = null;
    return true;
  }

  // Toggle password visibility
  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  // Toggle remember me
  void toggleRememberMe(bool? value) {
    rememberMe.value = value ?? false;
  }

  // Signup action
  Future<void> signup() async {
    final isEmailValid = validateEmail();
    final isEmailConfirmationValid = validateEmailConfirmation();
    final isPasswordValid = validatePassword();

    if (isEmailValid && isEmailConfirmationValid && isPasswordValid) {
      isLoading.value = true;

      // Unfocus before potential navigation
      Get.focusScope?.unfocus();

      // Simulate network request
      await Future.delayed(const Duration(seconds: 2));

      // Don't set isLoading to false here if we're navigating away
      // to avoid triggering an Obx rebuild of the disposing page.

      Get.snackbar(
        'Success',
        'Account created successfully. Please login.',
        backgroundColor: Colors.green.withOpacity(0.1),
        colorText: Colors.green,
        snackPosition: SnackPosition.TOP,
      );

      // Back to login
      Get.offAllNamed('/login');
    }
  }

  void goToLogin() {
    Get.back();
  }
}
