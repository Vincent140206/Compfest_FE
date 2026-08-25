import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:compfest/core/network/dio_client.dart';
import 'package:compfest/core/network/api_endpoints.dart';

class AuthController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final otpController = TextEditingController();

  var isLoading = false.obs;
  var registeredEmail = ''.obs;

  final _dio = DioClient().dio;

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    otpController.dispose();
    super.onClose();
  }

  Future<void> login() async {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      Get.snackbar('Error', 'Please fill all fields');
      return;
    }
    
    isLoading.value = true;
    try {
      final response = await _dio.post(
        ApiEndpoints.login,
        data: {
          'email': emailController.text,
          'password': passwordController.text,
        },
      );
      
      if (response.statusCode == 200) {
        final token = response.data['token'];
        if (token != null) {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('token', token);
        }
        Get.offAllNamed('/main');
      } else {
        Get.snackbar('Login Failed', response.data['message'] ?? 'Unknown error');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred during login');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> register() async {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      Get.snackbar('Error', 'Please fill all fields');
      return;
    }
    
    isLoading.value = true;
    try {
      final response = await _dio.post(
        ApiEndpoints.register,
        data: {
          'email': emailController.text,
          'password': passwordController.text,
        },
      );
      
      if (response.statusCode == 200 || response.statusCode == 201) {
        registeredEmail.value = emailController.text;
        Get.toNamed('/verify');
      } else {
        Get.snackbar('Registration Failed', response.data['message'] ?? 'Unknown error');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred during registration');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> verifyOtp() async {
    if (otpController.text.isEmpty) {
      Get.snackbar('Error', 'Please enter OTP');
      return;
    }
    
    isLoading.value = true;
    try {
      final response = await _dio.post(
        ApiEndpoints.verify,
        data: {
          'email': registeredEmail.value,
          'otp': otpController.text,
        },
      );
      
      if (response.statusCode == 200) {
        Get.offAllNamed('/main');
      } else {
        Get.snackbar('Verification Failed', response.data['message'] ?? 'Invalid OTP');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred during verification');
    } finally {
      isLoading.value = false;
    }
  }
}
