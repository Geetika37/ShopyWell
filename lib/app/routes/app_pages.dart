import 'package:get/get.dart';

import '../modules/home/bindings/home_binding.dart';
import '../modules/home/dashboard/bindings/dashboard_binding.dart';
import '../modules/home/dashboard/singleproduct/bindings/singleproduct_binding.dart';
import '../modules/home/dashboard/singleproduct/views/singleproduct_view.dart';
import '../modules/home/dashboard/views/dashboard_view.dart';
import '../modules/home/search/bindings/search_binding.dart';
import '../modules/home/search/views/search_view.dart';
import '../modules/home/setting/bindings/setting_binding.dart';
import '../modules/home/setting/views/setting_view.dart';
import '../modules/home/views/home_view.dart';
import '../modules/home/wishlist/bindings/wishlist_binding.dart';
import '../modules/home/wishlist/views/wishlist_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/onboarding/bindings/onboarding_binding.dart';
import '../modules/onboarding/views/onboarding_view.dart';
import '../modules/signup/bindings/signup_binding.dart';
import '../modules/signup/views/signup_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
      children: [
        GetPage(
          name: _Paths.DASHBOARD,
          page: () => const DashboardView(),
          binding: DashboardBinding(),
          children: [
            GetPage(
              name: _Paths.SINGLEPRODUCT,
              page: () => const SingleproductView(),
              binding: SingleproductBinding(),
            ),
          ],
        ),
        GetPage(
          name: _Paths.WISHLIST,
          page: () => const WishlistView(),
          binding: WishlistBinding(),
        ),
        GetPage(
          name: _Paths.SEARCH,
          page: () => const SearchView(),
          binding: SearchBinding(),
        ),
        GetPage(
          name: _Paths.SETTING,
          page: () => const SettingView(),
          binding: SettingBinding(),
        ),
      ],
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.ONBOARDING,
      page: () => const OnboardingView(),
      binding: OnboardingBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.SIGNUP,
      page: () => const SignupView(),
      binding: SignupBinding(),
    ),
  ];
}
