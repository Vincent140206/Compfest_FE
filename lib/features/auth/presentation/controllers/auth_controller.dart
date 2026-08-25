import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:compfest/core/network/dio_client.dart';
import 'package:compfest/core/network/api_endpoints.dart';
import 'package:dio/dio.dart';

class AuthController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final otpController = TextEditingController();

  var isLoading = false.obs;
  var registeredEmail = ''.obs;

  final _dio = DioClient().dio;

  @override
  void onClose() {
    super.onClose();
  }

  String _getErrorMessage(dynamic errorData, String fallback) {
    if (errorData == null) return fallback;
    if (errorData is Map) {
      return errorData['message']?.toString() ?? 
             errorData['error']?.toString() ?? 
             fallback;
    }
    if (errorData is String) {
      return errorData.isNotEmpty ? errorData : fallback;
    }
    return fallback;
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
        final data = response.data;
        final token = data['token'] ?? data['access_token'] ?? (data['data'] != null ? (data['data']['access_token'] ?? data['data']['token']) : null);
        
        if (token != null) {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('token', token);
          Get.offAllNamed('/main');
        } else {
          Get.snackbar('Login Failed', response.data['message'] ?? 'Unknown error');
        }
      } else {
        Get.snackbar('Login Failed', _getErrorMessage(response.data, 'Unknown error'));
      }
    } on DioException catch (e) {
      final errorMessage = _getErrorMessage(e.response?.data, e.message ?? 'An error occurred during login');
      Get.snackbar('Login Failed', errorMessage);
      print('Login Error: ${e.response?.data}');
    } catch (e) {
      Get.snackbar('Error', 'An error occurred during login');
      print('Login Error: $e');
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
        Get.snackbar('Registration Failed', _getErrorMessage(response.data, 'Unknown error'));
      }
    } on DioException catch (e) {
      final errorMessage = _getErrorMessage(e.response?.data, e.message ?? 'An error occurred during registration');
      Get.snackbar('Registration Failed', errorMessage);
      print('Register Error: ${e.response?.data}');
    } catch (e) {
      Get.snackbar('Error', 'An error occurred during registration');
      print('Register Error: $e');
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
    print('--- VERIFY OTP REQUEST ---');
    print('Email sent: ${registeredEmail.value}');
    print('OTP sent: ${otpController.text}');
    
    try {
      final response = await _dio.post(
        ApiEndpoints.verify,
        data: {
          'email': registeredEmail.value,
          'otp': otpController.text,
        },
      );
      
      print('--- VERIFY OTP RESPONSE ---');
      print('Status Code: ${response.statusCode}');
      print('Response Data: ${response.data}');
      
      if (response.statusCode == 200) {
        final data = response.data;
        final token = data['token'] ?? data['access_token'] ?? (data['data'] != null ? (data['data']['access_token'] ?? data['data']['token']) : null);
        
        if (token != null) {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('token', token);
          Get.offAllNamed('/main');
        } else {
          // Changed to redirect to login since API might not return token
          Get.snackbar('Verification Success', 'Your account has been verified. Please login to continue.');
          Get.offAllNamed('/login');
        }
      } else {
        Get.snackbar('Verification Failed', _getErrorMessage(response.data, 'Invalid OTP'));
      }
    } on DioException catch (e) {
      print('--- VERIFY OTP DIO EXCEPTION ---');
      print('Status Code: ${e.response?.statusCode}');
      print('Response Data: ${e.response?.data}');
      print('Error Message: ${e.message}');
      
      final errorMessage = _getErrorMessage(e.response?.data, e.message ?? 'An error occurred during verification');
      Get.snackbar('Verification Failed', errorMessage);
    } catch (e) {
      print('--- VERIFY OTP UNKNOWN ERROR ---');
      print(e);
      Get.snackbar('Error', 'An error occurred during verification');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    Get.offAllNamed('/login');
  }
}
