import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/custom_input_field.dart';
import '../controllers/reset_password_controller.dart';

class ResetPasswordView extends StatefulWidget {
  const ResetPasswordView({super.key});

  @override
  State<ResetPasswordView> createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends State<ResetPasswordView> {
  late final ResetPasswordController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.find<ResetPasswordController>();
    controller.newPasswordError.value = null;
    controller.confirmPasswordError.value = null;
    controller.newPasswordController.clear();
    controller.confirmPasswordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.black),
          onPressed: () => Get.back(),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Main content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),

                    // Title
                    Text(
                      'Reset',
                      style: GoogleFonts.poppins(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: AppColors.black,
                      ),
                    ),
                    Text(
                      'Password',
                      style: GoogleFonts.poppins(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: AppColors.black,
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Subtitle
                    Text(
                      'New Password',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColors.greyDark,
                      ),
                    ),

                    const SizedBox(height: 40),

                    // New Password Field
                    Obx(
                      () => AppTextField(
                        label: 'New Password',
                        controller: controller.newPasswordController,
                        errorText: controller.newPasswordError.value,
                        isPassword: true,
                        isRequired: true,
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Confirm Password Field
                    Obx(
                      () => AppTextField(
                        label: 'Confirm new password',
                        controller: controller.confirmPasswordController,
                        errorText: controller.confirmPasswordError.value,
                        isPassword: true,
                        isRequired: true,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Bottom bar with button
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppColors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              child: AppButton.primary(text: 'Submit', onPressed: controller.submit),
            ),
          ],
        ),
      ),
    );
  }
}
