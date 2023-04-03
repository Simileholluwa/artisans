import 'package:get/get.dart';
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

  ];






}
