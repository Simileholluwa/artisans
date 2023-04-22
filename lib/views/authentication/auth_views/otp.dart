import 'package:artisans/common/widgets/toast_message.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';
import '../../../common/widgets/app_button.dart';
import '../../../common/widgets/registration_progress.dart';
import '../controller.dart';

class OtpScreen extends GetView<AuthController> {
  final String? verificationId;
  const OtpScreen({Key? key, this.verificationId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: FlexColorScheme.themedSystemNavigationBar(
        context,
        systemNavBarStyle: FlexSystemNavBarStyle.scaffoldBackground,
        useDivider: false,
        opacity: 1,
      ),
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(65),
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Theme.of(context).dividerColor,
                ),
              ),
            ),
            child: AppBar(
              shadowColor: Colors.transparent,
              scrolledUnderElevation: 0,
              automaticallyImplyLeading: false,
              leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios_new_outlined,
                ),
                onPressed: () {
                  Get.back();
                },
              ),
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(FontAwesomeIcons.language),
                  splashRadius: 35,
                ),
                const SizedBox(width: 10),
              ],
              centerTitle: true,
              title: Text(
                'Verify your phone number',
                style: GoogleFonts.poppins(fontSize: 17),
              ),
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Obx(
            () => AppButton(
              onTap: controller.state.isLoading.isFalse ? () {
                if (controller.state.otpCode.value != '' &&
                    controller.state.otpCode.value.length == 6) {
                  controller.verifyOtp(
                    controller.state.otpCode.value,
                    verificationId!,
                    '+${controller.state.countries.value.phoneCode}${controller.state.phoneNumberController.text.trim()}',
                  );
                } else {
                  toastMessage('Enter 6-Digit verification code');
                }
              } : (){},
              icon: Icons.arrow_forward,
              textColor: Colors.white,
              iconColor: Colors.white,
              text: 'Next',
              isLoading: controller.state.isLoading.isFalse ? false : true,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 20.0,
              right: 20,
              top: 10,
            ),
            child: Column(
              children: [
                Text(
                  'artisan',
                  style: GoogleFonts.sacramento(
                    fontSize: 100,
                    color: Colors.pinkAccent,
                  ),
                ),
                const RegProgress(
                  isActive1: true,
                  isActive2: true,
                ),
                const SizedBox(
                  height: 40,
                ),
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        'Enter OTP code',
                        style: GoogleFonts.poppins(fontSize: 25, fontWeight: FontWeight.w500),
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                RichText(
                  text: TextSpan(
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w400, fontSize: 15, color: Theme.of(context).hintColor),
                    children: <TextSpan>[
                      const TextSpan(
                          text: 'We sent a verification code to '),
                      TextSpan(
                        text:
                            '+${controller.state.countries.value.phoneCode}${controller.state.phoneNumberController.text}. ',
                        style: GoogleFonts.poppins(fontWeight: FontWeight.w700),
                      ),
                      const TextSpan(
                          text: 'Go back if the phone number is incorrect.'),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Pinput(
                  length: 6,
                  showCursor: true,
                  autofocus: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter verification code";
                    } else if (value.length < 6) {
                      return "Verification code contains exactly six characters";
                    } else {
                      return null;
                    }
                  },
                  androidSmsAutofillMethod: AndroidSmsAutofillMethod.smsUserConsentApi,
                  defaultPinTheme: PinTheme(
                    width: 60,
                    height: 60,
                    textStyle: GoogleFonts.poppins(
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Theme.of(context).cardColor,
                    ),
                  ),
                  onCompleted: (value) {
                    controller.state.otpCode.value = value;
                  },
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Didn\'t receive code?',
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w200,
                            color: Theme.of(context).hintColor),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text('Resend code'),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
