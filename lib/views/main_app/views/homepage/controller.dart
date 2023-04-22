import 'package:artisans/common/routes/names.dart';
import 'package:artisans/common/store/store.dart';
import 'package:artisans/views/main_app/views/homepage/state.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  HomeController();
  final state = HomeState();

  void logout(){
    UserStore.to.onLogout();
    Get.offAllNamed(AppRoutes.auth);
  }

}