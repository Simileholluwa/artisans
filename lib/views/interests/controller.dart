import 'package:artisans/views/interests/index.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../common/routes/routes.dart';

class InterestsController extends GetxController with GetSingleTickerProviderStateMixin{
  InterestsController();
  final state = InterestsState();

  @override
  void onInit(){
    super.onInit();
    state.tabController = TabController(length: 8, vsync: this);
  }

  void goToHome(){
    Get.offAllNamed(AppRoutes.mainApp);
  }

}