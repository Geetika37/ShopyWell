import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shopywell/app/core/utils/easy_loader.dart';
import 'package:shopywell/app/core/utils/toasts.dart';
import 'package:shopywell/app/data/service/auth_service.dart';
import 'package:shopywell/app/data/service/user_service.dart';
import 'package:shopywell/app/routes/app_pages.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final AuthService _authService = Get.find<AuthService>();
  final UserService _userService = Get.find<UserService>();
  final RxBool passwordVisibility = false.obs;
  final formKey = GlobalKey<FormState>();
  final isPasswordVisible = false.obs;

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  Future<void> login() async {
    final email = emailController.text.trim();
    final password = passwordController.text;
    if (!formKey.currentState!.validate()) {
      return;
    }
    try {
      LoadingUtil.showLoading();
      final result = await _authService.signIn(email, password);
      if (result != null) {
        await _userService.loadUsers();
        Get.offAllNamed(Routes.HOME);
      }
    } catch (e) {
      Toasts.showError(e.toString());
    } finally {
      EasyLoading.dismiss();
    }
  }

  Future<dynamic> signInWithGoogle() async {
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

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
