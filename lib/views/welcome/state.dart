import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WelcomeState {
  var index = 0.obs;
  var artisanText = 'Effortlessly locate the best talent for your service on demand, and within your locality';
  var buttonText = 'Start searching';
  IconData buttonIcon = Icons.search;
  RxBool isVisible = false.obs;
  final random = Random();
}