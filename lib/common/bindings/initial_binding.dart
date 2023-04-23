import 'package:artisans/common/store/life_cycle.dart';
import 'package:artisans/common/store/store.dart';
import 'package:get/get.dart';
import '../services/services.dart';

class InitialBinding implements Bindings {
  @override
  Future<void> dependencies() async {
    await Get.putAsync<StorageService>(() => StorageService().init());
    Get.put<ConfigStore>(ConfigStore());
    Get.put<UserStore>(UserStore());
    Get.put<LifeCycleController>(LifeCycleController());
  }
}