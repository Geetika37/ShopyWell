import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopywell/app/core/constants/app_images.dart';
import 'package:shopywell/app/routes/app_pages.dart';

class OnboardingController extends GetxController {
  late PageController pageController;
  var currentPage = 0.obs;

  final List<OnboardingData> onboardingPages = [
    OnboardingData(
      image: Appimages.onboarding1,
      title: 'Choose Products',
      description:
          'Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit.',
    ),
    OnboardingData(
      image: Appimages.onboarding2,
      title: 'Make Payment',
      description:
          'Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit.',
    ),
    OnboardingData(
      image: Appimages.onboarding3,
      title: 'Get Your Order',
      description:
          'Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit..',
    ),
  ];

  @override
  void onInit() {
    super.onInit();
    pageController = PageController();
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  void nextPage() {
    if (currentPage.value < onboardingPages.length - 1) {
      currentPage.value++;
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      // Navigate to login page
      Get.offAllNamed(Routes.LOGIN);
    }
  }

  void skipOnboarding() {
    Get.offAllNamed(Routes.LOGIN);
  }

  void onPageChanged(int index) {
    currentPage.value = index;
  }
}

class OnboardingData {
  final String image;
  final String title;
  final String description;

  OnboardingData({
    required this.image,
    required this.title,
    required this.description,
  });
}
