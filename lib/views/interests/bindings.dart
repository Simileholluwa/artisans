import 'package:artisans/views/interests/controller.dart';
import 'package:get/get.dart';

class InterestsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InterestsController>(() => InterestsController());
  }

}