import 'package:artisans/common/routes/names.dart';
import 'package:artisans/common/widgets/toast_message.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth/error_codes.dart' as auth_error;

Future<void> localAuth() async {
  try {
    final localAuth = LocalAuthentication();
    final didAuthenticate = await localAuth.authenticate(
      localizedReason: 'Please authenticate',
      options: const AuthenticationOptions(
        biometricOnly: true,
        stickyAuth: true,
        useErrorDialogs: false,
      ),
    );
    if (didAuthenticate) {
      Get.offAllNamed(AppRoutes.mainApp);
    }
  } on PlatformException catch(e) {
    if (e.code == auth_error.notAvailable) {
      toastMessage('Your device does not support fingerprint biometrics');
    } else if (e.code == auth_error.passcodeNotSet){
      toastMessage('Set up passcode first');
    } else if(e.code == auth_error.notEnrolled) {
      toastMessage('Set up passcode first');
    } else {
      toastMessage(e.code);
    }
  }
}