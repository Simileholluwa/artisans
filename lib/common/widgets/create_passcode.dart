import 'package:artisans/common/utils/send_passcode.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screen_lock/flutter_screen_lock.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

Future<void> createPasscode() {

  return screenLockCreate(
    context: Get.context!,
    digits: 6,
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
                  'Enter a passcode',
                  style: GoogleFonts.poppins(fontSize: 25, fontWeight: FontWeight.w500, color: Theme.of(Get.context!).hintColor),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ],
      ),
    ),
    confirmTitle: Padding(
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
                  'Confirm your passcode',
                  style: GoogleFonts.poppins(fontSize: 25, fontWeight: FontWeight.w500, color: Theme.of(Get.context!).hintColor),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ],
      ),
    ),
    onConfirmed: (code) async {
      await sendPasscode(code);
    },
    config: ScreenLockConfig(
      backgroundColor: Theme.of(Get.context!).scaffoldBackgroundColor,
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
    canCancel: true,
    cancelButton: const Icon(Icons.close, size: 30,),
    deleteButton: const Icon(Icons.arrow_back_ios_sharp, size: 24,),
  );
}