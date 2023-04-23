import 'dart:ui';
import 'package:artisans/common/store/user.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../routes/names.dart';
import '../services/storage.dart';
import '../values/storage.dart';

class LifeCycleController extends SuperController{

  @override
  void onDetached() {
    if(kDebugMode){
      print('Detached');
    }
  }

  @override
  void onInactive() {
    final prevState = StorageService.to.getInt(lastKnownStateKey);
    final prevStateIsNotPaused = prevState != 0 && AppLifecycleState.values[prevState] != AppLifecycleState.paused;
    if(prevStateIsNotPaused){
      StorageService.to.setInt(backgroundTimeKey, DateTime.now().millisecondsSinceEpoch);
    }
    StorageService.to.setInt(lastKnownStateKey, AppLifecycleState.inactive.index);
  }

  @override
  void onPaused() {
    StorageService.to.setInt(lastKnownStateKey, AppLifecycleState.paused.index);
  }

  @override
  void onResumed() {
    final bgTime = StorageService.to.getInt(backgroundTimeKey);
    final allowedBackgroundTime = bgTime + lockScreenTime;
    final shouldShowPin = DateTime.now().millisecondsSinceEpoch > allowedBackgroundTime;
    if (shouldShowPin){
      if(UserStore.to.user.value != null) {
        Get.offAllNamed(AppRoutes.unlock);
      }
    }
    StorageService.to.remove(backgroundTimeKey);
    StorageService.to.setInt(lastKnownStateKey, AppLifecycleState.resumed.index);
  }

}