import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopywell/app/core/constants/app_images.dart';
import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});
  @override
  Widget build(BuildContext context) {
    controller.onInit();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28.0),
        child: Center(child: Image.asset(Appimages.splashlogo)),
      ),
    );
  }
}
