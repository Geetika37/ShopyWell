import 'package:get/get.dart';
import 'package:shopywell/app/data/service/auth_service.dart';
import 'package:shopywell/app/data/service/user_service.dart';
import '../controllers/signup_controller.dart';

class SignupBinding extends Bindings {
  @override
  void dependencies() {
    // Ensure services are initialized
    Get.lazyPut<AuthService>(() => AuthService(), fenix: true);
    Get.lazyPut<UserService>(() => UserService(), fenix: true);

    Get.lazyPut<SignupController>(() => SignupController());
  }
}
