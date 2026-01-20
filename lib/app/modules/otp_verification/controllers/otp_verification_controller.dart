import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';
import '../../../data/services/auth_service.dart';

class OtpVerificationController extends GetxController {
  final _authService = Get.find<AuthService>();

  // Pin Controller for Pinput
  final pinController = TextEditingController();

  // Current pin value
  final pin = ''.obs;

  // Resend timer
  final resendTimer = 59.obs;
  Timer? _timer;

  // Contact (email/mobile) from previous page
  late String contact;

  // Loading state
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();

    // Get contact from arguments
    contact = Get.arguments?['contact'] ?? '';

    // Start resend timer
    startResendTimer();
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }

  // Start resend timer
  void startResendTimer() {
    resendTimer.value = 59;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (resendTimer.value > 0) {
        resendTimer.value--;
      } else {
        timer.cancel();
      }
    });
  }

  // Verify OTP
  Future<void> verifyOtp() async {
    final otp = pin.value;

    if (otp.length != 4) {
      Get.snackbar(
        'Error',
        'Please enter complete OTP',
        backgroundColor: AppColors.error.withOpacity(0.1),
        colorText: AppColors.error,
      );
      return;
    }

    isLoading.value = true;
    try {
      final success = await _authService.verifyOtp(contact, otp);

      if (success) {
        Get.focusScope?.unfocus();
        Get.snackbar(
          'Success',
          'Verification successful',
          backgroundColor: Colors.green.withOpacity(0.1),
          colorText: Colors.green,
        );
        Get.offAllNamed('/main');
        return;
      } else {
        Get.snackbar(
          'Error',
          'Invalid OTP code',
          backgroundColor: AppColors.error.withOpacity(0.1),
          colorText: AppColors.error,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'An unexpected error occurred',
        backgroundColor: AppColors.error.withOpacity(0.1),
        colorText: AppColors.error,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Resend code
  Future<void> resendCode() async {
    if (resendTimer.value == 0) {
      isLoading.value = true;
      try {
        await _authService.sendOtp(contact);

        Get.snackbar(
          'Success',
          'OTP code has been resent',
          backgroundColor: AppColors.primary.withOpacity(0.1),
          colorText: AppColors.primary,
        );

        // Restart timer
        startResendTimer();

        // Clear OTP
        pinController.clear();
        pin.value = '';
      } catch (e) {
        Get.snackbar(
          'Error',
          'Failed to resend OTP',
          backgroundColor: AppColors.error.withOpacity(0.1),
          colorText: AppColors.error,
        );
      } finally {
        isLoading.value = false;
      }
    }
  }
}
