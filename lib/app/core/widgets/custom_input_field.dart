import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme/app_colors.dart';

/// Custom Input Field Component
///
/// Usage:
/// ```dart
/// // Email field
/// AppTextField(
///   label: 'Email',
///   controller: emailController,
///   errorText: 'Invalid Email',
///   isRequired: true,
/// )
///
/// // Password field
/// AppTextField(
///   label: 'Password',
///   controller: passwordController,
///   isPassword: true,
///   isRequired: true,
/// )
/// ```
class AppTextField extends StatefulWidget {
  final String label;
  final String hintText;
  final TextEditingController? controller;
  final String? errorText;
  final bool obscureText;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final ValueChanged<String>? onChanged;
  final bool isRequired;
  final bool isPassword;

  const AppTextField({
    super.key,
    required this.label,
    this.hintText = '',
    this.controller,
    this.errorText,
    this.obscureText = false,
    this.suffixIcon,
    this.keyboardType,
    this.onChanged,
    this.isRequired = false,
    this.isPassword = false,
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPassword || widget.obscureText;
  }

  void _toggleVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    final hasError = widget.errorText != null && widget.errorText!.isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label with red asterisk if required
        RichText(
          text: TextSpan(
            text: widget.label,
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: AppColors.black,
            ),
            children: [
              if (widget.isRequired)
                TextSpan(
                  text: '*',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: AppColors.error,
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 8),

        // Text Field
        TextField(
          controller: widget.controller,
          obscureText: _obscureText,
          keyboardType: widget.keyboardType,
          onChanged: widget.onChanged,
          style: GoogleFonts.poppins(fontSize: 14, color: AppColors.black),
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: GoogleFonts.poppins(fontSize: 14, color: AppColors.textHint),
            fillColor: hasError ? AppColors.backgroundError : AppColors.white,
            filled: true,
            suffixIcon: widget.isPassword
                ? IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                      color: AppColors.grey,
                    ),
                    onPressed: _toggleVisibility,
                  )
                : (widget.controller != null
                      ? ValueListenableBuilder<TextEditingValue>(
                          valueListenable: widget.controller!,
                          builder: (context, value, child) {
                            if (hasError && value.text.isNotEmpty) {
                              return IconButton(
                                icon: const Icon(Icons.close, color: AppColors.error, size: 20),
                                onPressed: () => widget.controller?.clear(),
                              );
                            }
                            return widget.suffixIcon ?? const SizedBox.shrink();
                          },
                        )
                      : widget.suffixIcon),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: hasError ? AppColors.error : AppColors.border,
                width: 1,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: hasError ? AppColors.error : AppColors.border,
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: hasError ? AppColors.error : AppColors.primary,
                width: 1,
              ),
            ),
          ),
        ),

        // Error Message
        if (hasError) ...[
          const SizedBox(height: 4),
          Row(
            children: [
              const Icon(Icons.error_outline, size: 14, color: AppColors.error),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  widget.errorText!,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.3,
                    height: 1.4,
                    color: const Color(0xFF1D1B20),
                  ),
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }
}
