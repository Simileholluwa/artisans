import 'package:firebase_auth/firebase_auth.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../common/widgets/widgets.dart';
import '../controller.dart';

class PhoneOrEmail extends GetView<AuthController> {
  const PhoneOrEmail({
    Key? key,
  }) : super(key: key);

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
                'Provide your email address',
                style: GoogleFonts.poppins(fontSize: 17),
              ),
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Obx(
            () => AppButton(
              onTap: () {
                final isValid = controller
                    .state.formKeyEmailOrPhone.currentState!
                    .validate();
                if (!isValid) {
                  return;
                } else {
                  controller.verifyAndLinkEmail(
                      controller.state.emailController.text.trim(),
                      true,
                      EmailAuthProvider.credential(
                          email: controller.state.emailController.text.trim(),
                          password:
                              "+${controller.state.countries.value.phoneCode}${controller.state.phoneNumberController.text.trim()}"));
                }
              },
              icon: Icons.arrow_forward,
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
                  isActive3: true,
                  isActive2: true,
                ),
                const SizedBox(
                  height: 40,
                ),
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        'What\'s your email address?',
                        style: GoogleFonts.poppins(fontSize: 25, fontWeight: FontWeight.w500),
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 1.0,
                    bottom: 20,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Text(
                          'Follow the link that will be sent to the email address provided to verify your email.',
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w300,
                              color: Theme.of(context).hintColor),
                        ),
                      ),
                    ],
                  ),
                ),
                Form(
                  key: controller.state.formKeyEmailOrPhone,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    children: [
                      CustomTextField(
                        addBorder: false,
                        filled: true,
                        onSaved: (value) {
                          controller.state.emailController.text = value!;
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter your email address";
                          } else if (!GetUtils.isEmail(value)) {
                            return "Please enter a valid email address";
                          } else {
                            return null;
                          }
                        },
                        inputFormatter: [
                          FilteringTextInputFormatter(' ', allow: false)
                        ],
                        inputAction: TextInputAction.done,
                        textInputType: TextInputType.emailAddress,
                        controller: controller.state.emailController,
                        prefixIcon: Padding(
                          padding: const EdgeInsets.only(
                            right: 10.0,
                            left: 1,
                          ),
                          child: Container(
                            height: 66,
                            width: 66,
                            decoration: BoxDecoration(
                              color: Colors.blue.shade800,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.only(
                                left: 5,
                                right: 5,
                                bottom: 1,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.mail,
                                    color: Colors.white,
                                    size: 35,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        hintText: 'Email address',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
