import 'package:artisans/common/widgets/setup_passcode.dart';
import 'package:artisans/common/widgets/unlock_app.dart';
import 'package:artisans/views/main_app/views/homepage/index.dart';
import 'package:get/get.dart';
import '../../views/authentication/index.dart';
import '../../views/interests/index.dart';
import '../../views/welcome/index.dart';
import '../middlewares/middlewares.dart';
import 'routes.dart';

class AppPages {
  static const initial = AppRoutes.initial;

  static final List<GetPage> routes = [

    GetPage(
      name: AppRoutes.initial,
      page: () => const Welcome(),
      binding: WelcomeBinding(),
      transition: Transition.downToUp,
      middlewares: [RouteWelcomeMiddleware(priority: 1)],
    ),

    GetPage(
      name: AppRoutes.auth,
      page: () => const Authentication(),
      binding: AuthBinding(),
      transition: Transition.downToUp,
    ),

    GetPage(
      name: AppRoutes.interests,
      page: () => const Interests(),
      binding: InterestsBinding(),
      transition: Transition.rightToLeft,
    ),

    GetPage(
      name: AppRoutes.otp,
      page: () => const OtpScreen(),
      transition: Transition.rightToLeft,
    ),

    GetPage(
      name: AppRoutes.emailAddress,
      page: () => const PhoneOrEmail(),
      transition: Transition.rightToLeft,
    ),

    GetPage(
      name: AppRoutes.passcode,
      page: () => const SetupPasscode(),
      transition: Transition.downToUp,
    ),

    GetPage(
      name: AppRoutes.unlock,
      page: () => const UnlockApp(),
      transition: Transition.downToUp,
    ),

    GetPage(
      name: AppRoutes.artisanID,
      page: () => const FullName(),
      transition: Transition.rightToLeft,
    ),

    GetPage(
      name: AppRoutes.mainApp,
      page: () => const Home(),
      transition: Transition.downToUp,
      binding: HomeBinding(),
    ),

  ];






}
