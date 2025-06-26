import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:remixicon/remixicon.dart';
import 'package:shopywell/app/core/constants/app_color.dart';
import 'package:shopywell/app/core/constants/app_images.dart';
import 'package:shopywell/app/core/widgets/custom_button.dart';
import 'package:shopywell/app/routes/app_pages.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight:
                    MediaQuery.of(context).size.height -
                    MediaQuery.of(context).padding.top,
              ),
              child: IntrinsicHeight(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 80),

                    // Welcome Back Title
                    _buildHeading(),
                    const SizedBox(height: 40),

                    // Username/Email Field
                    _buildUserName(),
                    const SizedBox(height: 16),

                    // Password Field
                    _buildPassword(),

                    // Forgot Password
                    _buildForgotPassword(),
                    const SizedBox(height: 20),

                    // Login Button
                    _buildLogin(),
                    // Flexible space instead of Spacer for scrollable content
                    const SizedBox(height: 40),

                    // OR Continue with
                    _buildContinueWith(),
                    const SizedBox(height: 20),

                    // Social Login Buttons
                    _buildButtons(),
                    const SizedBox(height: 30),

                    // Create Account
                    _buildCreateAccount(),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Center _buildCreateAccount() {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Create An Account ',
            style: TextStyle(color: AppColors.lightGreyColor, fontSize: 14),
          ),
          GestureDetector(
            onTap: () {
              Get.toNamed(Routes.SIGNUP);
            },
            child: const Text(
              'Sign Up',
              style: TextStyle(
                color: Colors.red,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Row _buildButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: () async {
            final result = await controller.signInWithGoogle();
            if (result != null) {
              Get.offAllNamed(Routes.HOME);
            }
          },
          child: _socialButton(Appimages.googleSign),
        ),
        const SizedBox(width: 20),
        _socialButton(Appimages.apple),
        const SizedBox(width: 20),
        _socialButton(Appimages.facebook),
      ],
    );
  }

  Center _buildContinueWith() {
    return Center(
      child: Text(
        '- OR Continue with -',
        style: TextStyle(color: AppColors.lightGreyColor, fontSize: 14),
      ),
    );
  }

  CustomButton _buildLogin() {
    return CustomButton(
      text: 'Login',
      onPressed: () {
        controller.login();
        // Get.offAllNamed(Routes.HOME);
      },
      buttoncolor: AppColors.primaryColor,
      textcolor: AppColors.white,
      radius: 4,
    );
  }

  Text _buildHeading() {
    return const Text(
      'Welcome\nBack!',
      style: TextStyle(
        fontSize: 36,
        fontWeight: FontWeight.w700,
        color: Colors.black,
        height: 1.2,
      ),
    );
  }

  Align _buildForgotPassword() {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () {},
        child: const Text(
          'Forgot Password?',
          style: TextStyle(color: Colors.red, fontSize: 14),
        ),
      ),
    );
  }

  Container _buildPassword() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Obx(
        () => TextField(
          controller: controller.passwordController,
          obscureText: !controller.isPasswordVisible.value,
          decoration: InputDecoration(
            hintText: 'Password',
            prefixIcon: const Icon(
              RemixIcons.lock_fill,
              color: AppColors.lightGreyColor,
            ),
            suffixIcon: GestureDetector(
              onTap: controller.togglePasswordVisibility,
              child: Icon(
                controller.isPasswordVisible.value
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
                color: AppColors.lightGreyColor,
              ),
            ),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
          ),
        ),
      ),
    );
  }

  Container _buildUserName() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        controller: controller.emailController,
        decoration: InputDecoration(
          hintText: 'Username or Email',
          prefixIcon: Icon(
            RemixIcons.user_fill,
            color: AppColors.lightGreyColor,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
        ),
      ),
    );
  }

  Widget _socialButton(String icon) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.red, width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SvgPicture.asset(icon, fit: BoxFit.contain),
      ),
    );
  }
}
