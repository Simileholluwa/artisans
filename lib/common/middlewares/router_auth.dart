import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../routes/names.dart';
import '../store/user.dart';

class RouteAuthMiddleware extends GetMiddleware {
  @override
  int? priority = 0;

  RouteAuthMiddleware({required this.priority});

  @override
  RouteSettings? redirect(String? route) {
    if (UserStore.to.isLogin || route == AppRoutes.auth || route == AppRoutes.initial) {
      return null;
    } else {
      Future.delayed(
          const Duration(seconds: 1));
      return const RouteSettings(name: AppRoutes.auth);
    }
  }
}
