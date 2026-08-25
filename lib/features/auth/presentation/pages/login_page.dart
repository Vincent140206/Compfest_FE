import 'package:compfest/core/theme/app_colors.dart';
import 'package:compfest/core/theme/app_typography.dart';
import 'package:compfest/features/auth/presentation/controllers/auth_controller.dart';
import 'package:compfest/shared/widgets/buttons/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final AuthController _authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Image.asset('assets/images/Invise.png', height: 48),
              ),
              const SizedBox(height: 48),
              Text(
                'Welcome Back',
                style: AppTypography.headline.copyWith(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'Login to manage your inventory',
                style: AppTypography.body.copyWith(color: AppColors.neutral),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              TextField(
                controller: _authController.emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  prefixIcon: const Icon(Icons.email_outlined),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _authController.passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: const Icon(Icons.lock_outline),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 24),
              Obx(() => PrimaryButton(
                text: 'Login',
                isLoading: _authController.isLoading.value,
                onPressed: _authController.login,
              )),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Don\'t have an account?', style: AppTypography.body),
                  TextButton(
                    onPressed: () {
                      _authController.emailController.clear();
                      _authController.passwordController.clear();
                      Get.toNamed('/register');
                    },
                    child: Text(
                      'Register',
                      style: AppTypography.label.copyWith(color: AppColors.primary, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        ),
      ),
    );
  }
}
