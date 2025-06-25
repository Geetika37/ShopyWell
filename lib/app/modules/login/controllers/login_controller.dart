// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:shopywell/app/data/service/auth_service.dart';
// import 'package:shopywell/app/routes/app_pages.dart';

// class LoginController extends GetxController {
//   final AuthService _authService = Get.find<AuthService>();

//   // Form controllers
//   final emailController = TextEditingController();
//   final passwordController = TextEditingController();

//   // Observables
//   final isLoading = false.obs;
//   final isPasswordVisible = false.obs;

//   @override
//   void onClose() {
//     emailController.dispose();
//     passwordController.dispose();
//     super.onClose();
//   }

//   Future<void> login() async {
//     if (emailController.text.isEmpty || passwordController.text.isEmpty) {
//       Get.snackbar('Error', 'Please fill in all fields');
//       return;
//     }

//     isLoading.value = true;

//     try {
//       final result = await _authService.signIn(
//         emailController.text.trim(),
//         passwordController.text,
//       );

//       if (result != null) {
//         // Login successful, navigate to home
//         Get.offAllNamed(Routes.HOME);
//       }
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   void goToSignup() {
//     Get.toNamed(Routes.SIGNUP);
//   }
// }

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
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
    // final email = emailController.text.trim();
    // final password = passwordController.text;
    final email = 'testuser@gmail.com';
    final password = 'Test123!';
    // if (!formKey.currentState!.validate()) {
    //   return;
    // }
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

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
