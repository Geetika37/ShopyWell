import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:shopywell/app/core/constants/app_color.dart';
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
                    const Text(
                      'Welcome\nBack!',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(height: 40),

                    // Username/Email Field
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: TextField(
                        controller: controller.emailController,
                        decoration: const InputDecoration(
                          hintText: 'Username or Email',
                          prefixIcon: Icon(
                            Icons.person_outline,
                            color: Colors.grey,
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 16,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Password Field
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.blue, width: 1),
                      ),
                      child: Obx(
                        () => TextField(
                          controller: controller.passwordController,
                          obscureText: !controller.isPasswordVisible.value,
                          decoration: InputDecoration(
                            hintText: 'Password',
                            prefixIcon: const Icon(
                              Icons.lock_outline,
                              color: Colors.grey,
                            ),
                            suffixIcon: GestureDetector(
                              onTap: controller.togglePasswordVisibility,
                              child: Icon(
                                controller.isPasswordVisible.value
                                    ? Icons.visibility_outlined
                                    : Icons.visibility_off_outlined,
                                color: Colors.grey,
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
                    ),

                    // Forgot Password
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Forgot Password?',
                          style: TextStyle(color: Colors.red, fontSize: 14),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Login Button
                    // SizedBox(
                    //   width: double.infinity,
                    //   height: 52,
                    //   child: ElevatedButton(
                    //     onPressed: controller.login,
                    //     style: ElevatedButton.styleFrom(
                    //       backgroundColor: Colors.red,
                    //       shape: RoundedRectangleBorder(
                    //         borderRadius: BorderRadius.circular(12),
                    //       ),
                    //       elevation: 0,
                    //     ),
                    //     child: const Text(
                    //       'Login',
                    //       style: TextStyle(
                    //         color: Colors.white,
                    //         fontSize: 16,
                    //         fontWeight: FontWeight.w600,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    CustomButton(
                      text: 'Login',
                      onPressed: () {
                        controller.login();
                        // Get.offAllNamed(Routes.HOME);
                      },
                      buttoncolor: AppColors.primaryColor,
                      textcolor: AppColors.black,
                    ),
                    // Flexible space instead of Spacer for scrollable content
                    const SizedBox(height: 40),

                    // OR Continue with
                    const Center(
                      child: Text(
                        '- OR Continue with -',
                        style: TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Social Login Buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _socialButton(Icons.g_mobiledata, Colors.red),
                        const SizedBox(width: 20),
                        _socialButton(Icons.apple, Colors.black),
                        const SizedBox(width: 20),
                        _socialButton(Icons.facebook, Colors.blue),
                      ],
                    ),
                    const SizedBox(height: 30),

                    // Create Account
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Create An Account ',
                            style: TextStyle(color: Colors.grey, fontSize: 14),
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.toNamed(Routes.SIGNUP);
                            },
                            child: const Text(
                              'Sign Up',
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
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

  Widget _socialButton(IconData icon, Color color) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.red, width: 1),
      ),
      child: Icon(icon, color: color, size: 24),
    );
  }
}
