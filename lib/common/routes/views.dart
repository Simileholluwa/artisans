import 'package:artisans/views/authentication/auth_views/otp.dart';
import 'package:get/get.dart';
import '../../views/authentication/index.dart';
import '../../views/interests/view.dart';
import '../../views/welcome/index.dart';
import 'routes.dart';

class AppPages {
  static const initial = AppRoutes.initial;

  static final List<GetPage> routes = [

    GetPage(
      name: AppRoutes.initial,
      page: () => const Welcome(),
      binding: WelcomeBinding(),
      transition: Transition.rightToLeft,
    ),

    GetPage(
      name: AppRoutes.auth,
      page: () => const Authentication(),
      binding: AuthBinding(),
      transition: Transition.downToUp,
    ),

    GetPage(
      name: AppRoutes.userDetails,
      page: () => const UserDetails(),
      binding: AuthBinding(),
      transition: Transition.rightToLeft,
    ),

    GetPage(
      name: AppRoutes.interests,
      page: () => const Interests(),
      transition: Transition.rightToLeft,
    ),

    GetPage(
      name: AppRoutes.otp,
      page: () => const OtpScreen(),
      transition: Transition.rightToLeft,
    ),

  ];






}
