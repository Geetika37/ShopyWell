import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:shopywell/app/data/service/auth_service.dart';
import 'package:shopywell/app/data/service/user_service.dart';
import 'package:shopywell/app/routes/app_pages.dart';

class SplashController extends GetxController {
  final AuthService _authService = Get.find<AuthService>();
  final UserService _userService = Get.find<UserService>();

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
      // User is authenticated, check if user document exists
      final userModel = await _authService.getUserByUid(currentUser.uid);

      if (userModel != null) {
        // User document exists, load user data and go to home
        await _userService.loadUsers();
        Get.offAllNamed(Routes.HOME);
      } else {
        // User is authenticated but no document exists, go to onboarding/login
        Get.offAllNamed(Routes.ONBOARDING);
      }
    } else {
      // User is not logged in, go to onboarding
      Get.offAllNamed(Routes.ONBOARDING);
    }
  }
}
