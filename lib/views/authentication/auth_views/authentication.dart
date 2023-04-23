import 'package:artisans/common/widgets/widgets.dart';
import 'package:artisans/views/authentication/controller.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Authentication extends GetView<AuthController> {
  const Authentication({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: FlexColorScheme.themedSystemNavigationBar(
        context,
        systemNavBarStyle: FlexSystemNavBarStyle.scaffoldBackground,
        useDivider: false,
        opacity: 1,
      ),
      child: OnAppExit(
        child: Scaffold(
          bottomNavigationBar: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10,),
            child: Obx(() => AppButton(
              onTap: controller.state.isLoading.isFalse ? () {
                final isValid =
                controller.state.formKey.currentState!.validate();
                if (!isValid) {
                  return;
                } else {
                  controller.state.formKey.currentState!.save();
                  controller.phoneSignIn(
                      "+${controller.state.countries.value.phoneCode}${controller.state.phoneNumberController.text},");
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
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(60),
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
                title: Text(
                  'Let\'s get you started',
                  style: GoogleFonts.poppins(fontSize: 17),
                ),
                actions: [
                  IconButton(
                      onPressed: (){},
                      icon: const Icon(FontAwesomeIcons.language),
                    splashRadius: 35,
                  ),
                  const SizedBox(width: 10),
                ],
              ),
            ),
          ),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20, bottom: 20, top: 10),
              child: Column(
                children: [
                  Text(
                    'artisan',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.sacramento(
                      fontSize: 100,
                      color: Colors.pinkAccent,
                    ),
                  ),
                  const RegProgress(
                    isActive1: true,
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          'What\'s your phone number?',
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
                    padding: const EdgeInsets.only(left: 1, bottom: 20),
                    child: Text('A verification code will be sent to verify your phone number. Enter the code in the next screen.',
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w300,
                          color: Theme.of(context).hintColor
                      ),
                    ),
                  ),
                  Form(
                    key: controller.state.formKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Column(
                      children: [
                        CustomTextField(
                          addBorder: false,
                          filled: true,
                          onSaved: (value) {
                            controller.state.phoneNumberController.text = value!;
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter your phone number";
                            } else if (value.startsWith(RegExp('0'))){
                              return "Enter your phone number without the leading \"0\"";
                            } else if (value.length != 10){
                              return "Phone number must be 10 digits long";
                            }
                            return null;
                          },
                          inputFormatter: [
                            FilteringTextInputFormatter('.', allow: false),
                          ],
                          inputAction: TextInputAction.done,
                          textInputType: TextInputType.number,
                          controller: controller.state.phoneNumberController,
                          prefixIcon: Padding(
                            padding: const EdgeInsets.only(
                              right: 10.0,
                              left: 1,
                            ),
                            child: Container(
                              height: 66,
                              width: 72,
                              decoration: BoxDecoration(
                                color: Colors.blue.shade800,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  left: 10,
                                  right: 10,
                                  bottom: 1,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Obx(
                                      () => Text(
                                        '+${controller.state.countries.value.phoneCode}',
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 20,
                                          color: Colors.white
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              showCountryPicker(
                                context: context,
                                onSelect: (value) {
                                  controller.state.countries.value = value;
                                },
                                countryListTheme: CountryListThemeData(
                                  backgroundColor:
                                      Theme.of(context).scaffoldBackgroundColor,
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    topRight: Radius.circular(15),
                                  ),
                                  inputDecoration: InputDecoration(
                                    prefixIcon: const Icon(Icons.search),
                                    hintText: 'Search',
                                    filled: false,
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide(
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide(
                                        color: Theme.of(context).primaryColor,
                                        width: 2.0,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                            icon: const Icon(Icons.arrow_drop_down_sharp),
                            iconSize: 30,
                          ),
                          hintText: 'Phone number',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
