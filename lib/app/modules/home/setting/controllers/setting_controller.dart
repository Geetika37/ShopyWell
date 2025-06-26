import 'package:get/get.dart';
import 'package:shopywell/app/data/service/auth_service.dart';
import 'package:shopywell/app/routes/app_pages.dart';

class SettingController extends GetxController {
  final AuthService _authService = Get.find<AuthService>();

  Future<void> logout() async {
    try {
      await _authService.signOut();
      Get.offAllNamed(Routes.LOGIN);
    } catch (e) {
      Get.snackbar('Error', 'Failed to logout: ${e.toString()}');
    }
  }
}
