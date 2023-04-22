import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WelcomeState {
  var index = 0.obs;
  var opacity = 0.0.obs;
  var opacity1 = 0.0.obs;
  var opacity2 = 0.0.obs;
  var opacity3 = 0.0.obs;
  var btnText = 'Next'.obs;
  Rx<IconData> icon = Icons.arrow_forward.obs;
}