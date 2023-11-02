import 'package:get/get.dart';

import '../modules/activity_details/bindings/activity_details_binding.dart';
import '../modules/activity_details/views/activity_details_view.dart';
import '../modules/activity_list/bindings/activity_list_binding.dart';
import '../modules/activity_list/views/activity_list_view.dart';
import '../modules/bottom_nav_bar/bindings/bottom_nav_bar_binding.dart';
import '../modules/bottom_nav_bar/views/bottom_nav_bar_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/registration/bindings/registration_binding.dart';
import '../modules/registration/views/registration_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.LOGIN;
  static const BOTTOM_NAV_BAR = Routes.BOTTOM_NAV_BAR;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.REGISTRATION,
      page: () => const RegistrationView(),
      binding: RegistrationBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.BOTTOM_NAV_BAR,
      page: () => const BottomNavBarView(),
      binding: BottomNavBarBinding(),
    ),
    GetPage(
      name: _Paths.ACTIVITY_LIST,
      page: () => const ActivityListView(),
      binding: ActivityListBinding(),
    ),
    GetPage(
      name: _Paths.ACTIVITY_DETAILS,
      page: () => const ActivityDetailsView(),
      binding: ActivityDetailsBinding(),
    ),
  ];
}
