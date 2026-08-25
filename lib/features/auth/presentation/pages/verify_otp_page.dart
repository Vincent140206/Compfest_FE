import 'package:compfest/core/theme/app_colors.dart';
import 'package:compfest/core/theme/app_typography.dart';
import 'package:compfest/features/auth/presentation/controllers/auth_controller.dart';
import 'package:compfest/shared/widgets/buttons/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VerifyOtpPage extends StatelessWidget {
  VerifyOtpPage({super.key});

  final AuthController _authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.primary),
          onPressed: () => Get.back(),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 16),
              Text(
                'Verify Email',
                style: AppTypography.headline.copyWith(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Obx(() => Text(
                'Please enter the 6-digit code sent to\n${_authController.registeredEmail.value}',
                style: AppTypography.body.copyWith(color: AppColors.neutral),
                textAlign: TextAlign.center,
              )),
              const SizedBox(height: 32),
              TextField(
                controller: _authController.otpController,
                decoration: InputDecoration(
                  labelText: 'OTP Code',
                  prefixIcon: const Icon(Icons.security),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  counterText: '',
                ),
                keyboardType: TextInputType.number,
                maxLength: 6,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 24, letterSpacing: 8, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 32),
              Obx(() => PrimaryButton(
                text: 'Verify',
                isLoading: _authController.isLoading.value,
                onPressed: _authController.verifyOtp,
              )),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Didn\'t receive code?', style: AppTypography.body),
                  TextButton(
                    onPressed: () {
                      Get.snackbar('Sent', 'A new OTP has been sent.');
                    },
                    child: Text(
                      'Resend',
                      style: AppTypography.label.copyWith(color: AppColors.primary, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
