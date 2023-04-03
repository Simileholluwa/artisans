import 'dart:math';

import 'package:artisans/views/welcome/index.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WelcomeController extends GetxController{
  WelcomeController();

  final state = WelcomeState();

  void changePage(int index) async {
    state.index.value = index;
    switch(state.index.value){
      case 1:
        state.artisanText = 'Give your skill or product a befitting visibility that can compete in the global market';
        state.buttonText = 'Start selling';
        state.buttonIcon = const Icon(Icons.money, color: Colors.white,);
        break;
      case 2:
        state.artisanText = 'Choose from a pool of proposals. Interview your favorites and hire the best fit';
        state.buttonText = 'Post your project';
        state.buttonIcon = const Icon(Icons.event_note_sharp, color: Colors.white,);
      case 3:
        state.artisanText = 'We aim to expose the undiscovered potential of the Nigerian people to the world';
        state.buttonText = 'Join us';
        state.buttonIcon = const Icon(Icons.join_full, color: Colors.white,);
        break;
      default:
        state.artisanText = 'Locate the best talent for your service on demand, and within your locality';
        state.buttonText =  'Start searching';
        state.buttonIcon = const Icon(Icons.search, color: Colors.white,);
    }
  }

}