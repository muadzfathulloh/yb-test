import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/custom_input_field.dart';
import '../controllers/login_controller.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final LoginController controller;

  @override
  void initState() {
    super.initState();
    // Get controller and reset immediately
    controller = Get.find<LoginController>();
    controller.emailError.value = null;
    controller.passwordError.value = null;
    controller.emailController.clear();
    controller.passwordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 60),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Hello',
                        style: GoogleFonts.poppins(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          color: AppColors.black,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Again!',
                        style: GoogleFonts.poppins(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                          height: 0.8,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Welcome back you\'ve',
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: AppColors.black,
                        ),
                      ),
                      Text(
                        'been missed',
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: AppColors.black,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: 20,
                    width: 20,
                    decoration: BoxDecoration(color: AppColors.green, shape: BoxShape.circle),
                  ),
                ],
              ),
              const SizedBox(height: 60),

              // Email Field
              Obx(
                () => AppTextField(
                  label: 'Email',
                  controller: controller.emailController,
                  errorText: controller.emailError.value,
                  keyboardType: TextInputType.emailAddress,
                  isRequired: true,
                ),
              ),

              const SizedBox(height: 20),

              // Password Field
              Obx(
                () => AppTextField(
                  label: 'Password',
                  controller: controller.passwordController,
                  errorText: controller.passwordError.value,
                  isRequired: true,
                  isPassword: true,
                ),
              ),

              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Obx(
                    () => Row(
                      children: [
                        SizedBox(
                          width: 24,
                          height: 24,
                          child: Checkbox(
                            value: controller.rememberMe.value,
                            onChanged: controller.toggleRememberMe,
                            activeColor: AppColors.primary,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text('Remember me', style: GoogleFonts.poppins(color: AppColors.black)),
                      ],
                    ),
                  ),
                  // Forgot Password
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () => Get.toNamed('/forgot-password'),
                      child: Text(
                        'Forgot the password?',
                        style: GoogleFonts.poppins(color: AppColors.primary),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 32),

              // Login Button
              Obx(
                () => AppButton.primary(
                  text: 'Login',
                  isLoading: controller.isLoading.value,
                  onPressed: () => controller.login(),
                ),
              ),

              const SizedBox(height: 20),
              Center(
                child: Text(
                  'or continue with',
                  style: GoogleFonts.poppins(color: AppColors.greyDark),
                ),
              ),

              const SizedBox(height: 20),
              Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                  decoration: BoxDecoration(
                    color: AppColors.greyLight,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.network(
                        'https://upload.wikimedia.org/wikipedia/commons/thumb/c/c1/Google_"G"_logo.svg/1200px-Google_"G"_logo.svg.png',
                        height: 24,
                        width: 24,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        'Google',
                        style: GoogleFonts.poppins(
                          color: AppColors.greyDark,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),
              Center(
                child: TextButton(
                  onPressed: controller.goToSignUp,
                  child: RichText(
                    text: TextSpan(
                      text: 'don\'t have an account? ',
                      style: GoogleFonts.poppins(color: AppColors.greyDark),
                      children: [
                        TextSpan(
                          text: 'Sign Up',
                          style: GoogleFonts.poppins(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
