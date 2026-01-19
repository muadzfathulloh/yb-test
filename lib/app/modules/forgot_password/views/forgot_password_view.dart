import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/custom_input_field.dart';
import '../controllers/forgot_password_controller.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({super.key});

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  late final ForgotPasswordController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.find<ForgotPasswordController>();
    controller.emailError.value = null;
    controller.emailController.clear();
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
                      'Forgot',
                      style: GoogleFonts.poppins(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: AppColors.black,
                      ),
                    ),
                    Text(
                      'Password ?',
                      style: GoogleFonts.poppins(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: AppColors.black,
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Subtitle
                    Text(
                      'Don\'t worry it happens. Please enter the',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColors.greyDark,
                      ),
                    ),
                    Text(
                      'address associated with your account.',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColors.greyDark,
                      ),
                    ),

                    const SizedBox(height: 40),

                    // Email / Mobile Field
                    Obx(
                      () => AppTextField(
                        label: 'Email / Mobile number',
                        controller: controller.emailController,
                        errorText: controller.emailError.value,
                        keyboardType: TextInputType.emailAddress,
                        isRequired: false,
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
