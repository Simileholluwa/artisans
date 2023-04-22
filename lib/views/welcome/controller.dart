import 'package:artisans/views/welcome/index.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../common/routes/names.dart';
import '../../common/store/store.dart';

class WelcomeController extends GetxController {
  WelcomeController();

  final state = WelcomeState();

  @override
  void onReady() {
    super.onReady();
    state.opacity.value = 1.0;
  }

  void openAuthScreen() async {
    await ConfigStore.to.saveAlreadyOpen();
    Get.offAllNamed(AppRoutes.auth);
  }

  void changeIndex() async {
    state.index.value += 1;
    if (state.index.value == 1) {
      state.opacity1.value = 1.0;
    }
    if (state.index.value == 2) {
      state.opacity2.value = 1.0;
    }
    if (state.index.value == 3) {
      state.opacity3.value = 1.0;
      state.btnText.value = 'Join us';
      state.icon.value = Icons.join_full;
    }
  }
}
