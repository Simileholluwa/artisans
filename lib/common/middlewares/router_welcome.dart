import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../routes/names.dart';
import '../store/store.dart';

class RouteWelcomeMiddleware extends GetMiddleware {
  @override
  int? priority = 0;

  RouteWelcomeMiddleware({required this.priority});

  @override
  RouteSettings? redirect(String? route) {
    if (ConfigStore.to.isFirstOpen == false) {
      return null;
    } else if (UserStore.to.isLogin == true || UserStore.to.user.value != null) {
      if(ConfigStore.to.passcodeSet == false) {
        return const RouteSettings(name: AppRoutes.passcode);
      } else {
        return const RouteSettings(name: AppRoutes.unlock,);
      }
    } else {
      return const RouteSettings(name: AppRoutes.auth);
    }
  }
}
