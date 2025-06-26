import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:shopywell/app/core/constants/app_theme.dart';
import 'package:shopywell/app/data/service/auth_service.dart';
import 'package:shopywell/app/data/service/user_service.dart';
import 'package:shopywell/app/modules/splash/bindings/splash_binding.dart';
import 'package:shopywell/firebase_options.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Get.putAsync(() async => AuthService());
  await Get.putAsync(() async => UserService());
  await dotenv.load(fileName: ".env");
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Shopywell",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      initialBinding: SplashBinding(),
      theme: AppTheme.theme,
      builder: EasyLoading.init(),
    ),
  );
}
