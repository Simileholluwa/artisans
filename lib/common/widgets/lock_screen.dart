import 'package:artisans/common/utils/send_email.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screen_lock/flutter_screen_lock.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../routes/names.dart';

Future<void> lockScreen(String correctString) {

  final inputController = InputController();

  return screenLock(
    context: Get.context!,
    inputController: inputController,
    title: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          Text(
            'artisan',
            style: GoogleFonts.sacramento(
              fontSize: 100,
              color: Colors.pinkAccent,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Text(
                  'Enter your passcode',
                  style: GoogleFonts.poppins(fontSize: 25, fontWeight: FontWeight.w500, color: Theme.of(Get.context!).hintColor,),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ],
      ),
    ),
    onUnlocked: () {
      Get.offAllNamed(AppRoutes.mainApp);
    },
    canCancel: true,
    customizedButtonChild: Icon(CupertinoIcons.chat_bubble_text, size: 35, color: Theme.of(Get.context!).iconTheme.color,),
    customizedButtonTap: () async {
      openEmail();
    },
    config: ScreenLockConfig(
      backgroundColor: Theme.of(Get.context!).scaffoldBackgroundColor,
      textStyle: GoogleFonts.poppins(
          fontWeight: FontWeight.w300,
          color: Theme.of(Get.context!).hintColor,
          fontSize: 15
      ),
      titleTextStyle: GoogleFonts.poppins(fontSize: 25, fontWeight: FontWeight.w500, color: Theme.of(Get.context!).iconTheme.color),
    ),
    secretsConfig: SecretsConfig(
      spacing: 15, // or spacingRatio
      padding: const EdgeInsets.only(bottom:30, top: 60),
      secretConfig: SecretConfig(
        size: 30,
        borderColor: Theme.of(Get.context!).highlightColor,
        borderSize: 2.0,
        disabledColor: Theme.of(Get.context!).canvasColor,
        enabledColor: Colors.pinkAccent,
      ),
    ),
    keyPadConfig: KeyPadConfig(
      buttonConfig: KeyPadButtonConfig(
        size: 100,
        buttonStyle: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
          side: const BorderSide(
              width: 0,
              color: Colors.transparent
          ),
          foregroundColor: Theme.of(Get.context!).iconTheme.color,
        ),
      ),
      actionButtonConfig: KeyPadButtonConfig(
        size: 90,
        buttonStyle: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
          side: const BorderSide(
              width: 0,
              color: Colors.transparent
          ),
          foregroundColor: Theme.of(Get.context!).iconTheme.color,
        ),
      ),
    ),
    cancelButton: const Icon(Icons.close, size: 30,),
    deleteButton: const Icon(Icons.arrow_back_ios_sharp, size: 24,),
    correctString: correctString,
  );
}