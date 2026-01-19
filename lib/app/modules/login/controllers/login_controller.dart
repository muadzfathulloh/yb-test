import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/services/auth_service.dart';

class LoginController extends GetxController {
  final _authService = Get.find<AuthService>();

  // Text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // Observable states
  final emailError = RxnString();
  final passwordError = RxnString();
  final isPasswordVisible = false.obs;
  final rememberMe = true.obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();

    // Add listeners to validate on change
    emailController.addListener(() {
      if (emailError.value != null) {
        validateEmail();
      }
    });
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
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

  // Password validation
  bool validatePassword() {
    final password = passwordController.text;

    // Check if empty (required validation)
    if (password.isEmpty) {
      passwordError.value = 'Password is required';
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

  // Login action
  Future<void> login() async {
    final isEmailValid = validateEmail();
    final isPasswordValid = validatePassword();

    if (isEmailValid && isPasswordValid) {
      isLoading.value = true;
      try {
        final result = await _authService.login(
          emailController.text.trim(),
          passwordController.text,
        );

        if (result.success) {
          if (result.isFirstTime) {
            Get.toNamed('/otp-verification', arguments: {'contact': emailController.text.trim()});
          } else {
            Get.offAllNamed('/main');
          }
        } else {
          Get.snackbar(
            'Login Failed',
            result.message ?? 'Invalid email or password',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red.withOpacity(0.8),
            colorText: Colors.white,
          );
        }
      } catch (e) {
        Get.snackbar(
          'Error',
          'An unexpected error occurred',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red.withOpacity(0.8),
          colorText: Colors.white,
        );
      } finally {
        isLoading.value = false;
      }
    }
  }

  void goToSignUp() {
    Get.toNamed('/signup');
  }
}
