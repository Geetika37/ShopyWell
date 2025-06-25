import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shopywell/app/core/utils/easy_loader.dart';
import 'package:shopywell/app/core/utils/toasts.dart';
import 'package:shopywell/app/data/service/auth_service.dart';
import 'package:shopywell/app/data/models/user_model.dart';
import 'package:shopywell/app/routes/app_pages.dart';

class SignupController extends GetxController {
  final AuthService _authService = Get.find<AuthService>();

  // Form controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // Observables
  final isLoading = false.obs;
  final isPasswordVisible = false.obs;
  final isConfirmPasswordVisible = false.obs;

  @override
  void onClose() {
    emailController.dispose();

    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
  }

  bool _validateForm() {
    if (emailController.text.isEmpty ||
        !GetUtils.isEmail(emailController.text)) {
      Toasts.showError('Please enter a valid email');
      return false;
    }

    if (passwordController.text.isEmpty || passwordController.text.length < 6) {
      Toasts.showError('Password must be at least 6 characters');

      return false;
    }

    if (passwordController.text != confirmPasswordController.text) {
      Toasts.showError('Passwords do not match');
      return false;
    }

    return true;
  }

  Future<void> createAccount() async {
    if (!_validateForm()) return;

    try {
      LoadingUtil.showLoading();
      // Create user with Firebase Auth
      final result = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text,
      );

      log('User created: ${result.user?.uid}');

      if (result.user != null) {
        // Create user document in Firestore
        final userModel = UserModel(
          uid: result.user!.uid,
          email: emailController.text.trim(),
          createdAt: DateTime.now(),
        );

        log('Creating user document for ${userModel.email}');

        await _authService.createUserDocument(userModel, result.user!.uid);

        // Refresh user cache
        // await _userService.refreshUserCache();

        Get.snackbar(
          'Success',
          'Account created successfully!',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );

        // Navigate to login
        Get.offNamed(Routes.HOME);
      }
    } catch (e) {
      Toasts.showError(e.toString());
    } finally {
      EasyLoading.dismiss();
    }
  }

  void goToLogin() {
    Get.back();
  }
}
