import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:shopywell/app/routes/app_pages.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    navigateToNextScreen();
    super.onInit();
  }

  Future<void> navigateToNextScreen() async {
    await Future.delayed(const Duration(seconds: 3));

    // Check if user is already logged in
    final currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null && !currentUser.isAnonymous) {
      // User is logged in, go to home
      Get.offAllNamed(Routes.HOME);
    } else {
      // User is not logged in, go to onboarding
      Get.offAllNamed(Routes.ONBOARDING);
    }
  }
}
