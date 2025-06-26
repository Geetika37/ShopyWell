import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:remixicon/remixicon.dart';
import 'package:shopywell/app/core/constants/app_color.dart';
import 'package:shopywell/app/core/constants/app_images.dart';
import 'package:shopywell/app/routes/app_pages.dart';
import '../controllers/signup_controller.dart';

class SignupView extends GetView<SignupController> {
  const SignupView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 60),

                // Title
                _buildHeading(),
                const SizedBox(height: 40),

                // Email Field
                _buildUsername(),
                const SizedBox(height: 16),

                // Password Field
                _buildPassword(),
                const SizedBox(height: 16),

                // Confirm Password Field
                _buildConfirmPassword(),
                const SizedBox(height: 16),

                // Terms and Conditions
                _buildTermsConditions(),
                const SizedBox(height: 24),

                // Create Account Button
                _buildCreateAccount(),
                const SizedBox(height: 30),

                // OR Continue with
                _buildContinue(),
                const SizedBox(height: 20),

                // Social Login Buttons
                _buildButton(),
                const SizedBox(height: 30),

                // Already have account
                _buildAlreadyAccount(),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Center _buildAlreadyAccount() {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'I Already Have an Account ',
            style: TextStyle(color: Colors.grey, fontSize: 14),
          ),
          GestureDetector(
            onTap: controller.goToLogin,
            child: const Text(
              'Login',
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

  Row _buildButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: () async {
            final result = await controller.signUpWithGoogle();
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

  Center _buildContinue() {
    return const Center(
      child: Text(
        '- OR Continue with -',
        style: TextStyle(color: Colors.grey, fontSize: 14),
      ),
    );
  }

  SizedBox _buildCreateAccount() {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        onPressed: controller.createAccount,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          elevation: 0,
        ),
        child: const Text(
          'Create Account',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  RichText _buildTermsConditions() {
    return RichText(
      text: const TextSpan(
        style: TextStyle(color: Colors.grey, fontSize: 14),
        children: [
          TextSpan(
            text: 'By clicking the ',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          TextSpan(
            text: 'Register',
            style: TextStyle(
              color: Colors.red,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          TextSpan(
            text: ' button, you agree\nto the public offer',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Container _buildConfirmPassword() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Obx(
        () => TextField(
          controller: controller.confirmPasswordController,
          obscureText: !controller.isConfirmPasswordVisible.value,
          decoration: InputDecoration(
            hintText: 'Confirm Password',
            prefixIcon: const Icon(
              RemixIcons.lock_fill,
              color: AppColors.lightGreyColor,
            ),
            suffixIcon: GestureDetector(
              onTap: controller.toggleConfirmPasswordVisibility,
              child: Icon(
                controller.isConfirmPasswordVisible.value
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

  Container _buildUsername() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        controller: controller.emailController,
        keyboardType: TextInputType.emailAddress,
        decoration: const InputDecoration(
          hintText: 'Username or Email',
          prefixIcon: Icon(
            RemixIcons.user_fill,
            color: AppColors.lightGreyColor,
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        ),
      ),
    );
  }

  Text _buildHeading() {
    return const Text(
      'Create an\naccount',
      style: TextStyle(
        fontSize: 36,
        fontWeight: FontWeight.w700,
        color: Colors.black,
        height: 1.2,
      ),
    );
  }
}
