import 'package:get/get.dart';
import 'package:shopywell/app/data/service/auth_service.dart';
import 'package:shopywell/app/data/service/user_service.dart';
import '../controllers/splash_controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    // Initialize core services first
    Get.put<AuthService>(AuthService(), permanent: true);
    Get.put<UserService>(UserService(), permanent: true);

    Get.lazyPut<SplashController>(() => SplashController());
  }
}
