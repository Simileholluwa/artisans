import 'package:artisans/common/widgets/toast_message.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import '../../../common/widgets/app_button.dart';
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
              centerTitle: true,
              title: Text(
                'Verify your phone number',
                style: Theme.of(context).textTheme.bodyLarge!,
              ),
            ),
          ),
        ),
        bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(20),
          child: AppButton(
            onTap: () {
              if (controller.state.otpCode.value != '' && controller.state.otpCode.value.length != 6) {
                controller.verifyOtp(controller.state.otpCode.value, verificationId!);
              } else {
                toastMessage('Enter 6-Digit verification code');
              }
            },
            icon: FontAwesomeIcons.solidPaperPlane,
            textColor: Colors.white,
            iconColor: Colors.white,
            text: 'Continue',
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left:20.0, right: 20, top: 40,),
            child: Column(
              children: [
                Text(
                  'Enter the verification code sent to +${controller.state.countries.value.phoneCode}${controller.state.phoneNumberController.text}',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 30,),
                Pinput(
                  length: 6,
                  showCursor: true,
                  autofocus: true,
                  validator: (value){
                    if(value!.isEmpty) {
                      return "Please enter verification code";
                    } else if (value.length < 6) {
                      return "Verification code contains exactly six characters";
                    } else {
                      return null;
                    }
                  },
                  defaultPinTheme: PinTheme(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Theme.of(context).cardColor,
                    ),
                  ),
                  onCompleted:(value) {
                    controller.state.otpCode.value = value;
                  },
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Did not receive code?'),
                    const SizedBox(width: 10,),
                    TextButton(
                        onPressed: (){},
                        child: const Text('Resend code'),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
