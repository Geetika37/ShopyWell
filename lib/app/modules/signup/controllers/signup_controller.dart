import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shopywell/app/core/utils/easy_loader.dart';
import 'package:shopywell/app/core/utils/toasts.dart';
import 'package:shopywell/app/data/service/auth_service.dart';
import 'package:shopywell/app/data/models/user_model.dart';
import 'package:shopywell/app/data/service/user_service.dart';
import 'package:shopywell/app/routes/app_pages.dart';

class SignupController extends GetxController {
  final AuthService _authService = Get.find<AuthService>();
  final UserService _userService = Get.find<UserService>();

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

  Future<dynamic> signUpWithGoogle() async {
    LoadingUtil.showLoading('Signing in with Google...');
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn(
        scopes: ['email', 'https://www.googleapis.com/auth/userinfo.profile'],
      );

      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      if (googleUser == null) {
        // User cancelled the sign-in
        return false;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await FirebaseAuth.instance.signInWithCredential(
        credential,
      );

      // Process Google sign-in through AuthService
      final result = await _authService.signInWithGoogle(userCredential);

      if (result != null) {
        // Load user data into UserService
        await _userService.loadUsers();
        return result;
      }

      return false;
    } catch (e) {
      Toasts.showError('Error during Google Sign-In $e');
      log('Error during Google Sign-In: $e');
      return false;
    } finally {
      LoadingUtil.dismiss();
    }
  }

  void goToLogin() {
    Get.back();
  }
}
