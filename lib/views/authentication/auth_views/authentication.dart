import 'package:artisans/common/widgets/widgets.dart';
import 'package:artisans/views/authentication/controller.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

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
                'Let\'s get you started',
                style: Theme.of(context).textTheme.bodyLarge!,
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'artisan',
                      style: Theme.of(context)
                          .textTheme
                          .headlineLarge!
                          .copyWith(fontSize: 50, color: Colors.pinkAccent),
                    ),
                  ],
                ),
                const Text(
                  'Local talents and services at your fingertips',
                ),
                const SizedBox(
                  height: 50,
                ),
                Form(
                  key: controller.state.formKey,
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
                          } else {
                            return null;
                          }
                        },
                        inputFormatter: [
                          FilteringTextInputFormatter('.', allow: false)
                        ],
                        inputAction: TextInputAction.done,
                        textInputType: TextInputType.number,
                        controller: controller.state.phoneNumberController,
                        prefixIcon: Padding(
                          padding: const EdgeInsets.only(
                            right: 10.0,
                            left: 1,
                          ),
                          child: Material(
                            type: MaterialType.transparency,
                            borderRadius: BorderRadius.circular(10),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(10),
                              onTap: () {
                                showCountryPicker(
                                  context: context,
                                  onSelect: (value) {
                                    controller.state.countries.value = value;
                                  },
                                  countryListTheme: CountryListThemeData(
                                    backgroundColor: Theme.of(context)
                                        .scaffoldBackgroundColor,
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
                              child: Ink(
                                height: 62,
                                width: 62,
                                decoration: BoxDecoration(
                                  color: Colors.blue,
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
                                      Text(
                                        '+${controller.state.countries.value.phoneCode}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .copyWith(
                                              color: Colors.white,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        hintText: 'Mobile number',
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 2.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Flexible(
                              child: Text(
                                'A verification code will be sent to verify your mobile number. Enter the code in the next screen.',
                                style: Theme.of(context)
                                    .textTheme
                                    .labelSmall!
                                    .copyWith(
                                      color: Theme.of(context).hintColor,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      AppButton(
                        onTap: () {
                          final isValid =
                              controller.state.formKey.currentState!.validate();
                          if (!isValid) {
                            return;
                          } else {
                            controller.state.formKey.currentState!.save();
                            controller.phoneSignIn(
                                "+${controller.state.countries.value.phoneCode}${controller.state.phoneNumberController.text},");
                          }
                        },
                        icon: FontAwesomeIcons.solidPaperPlane,
                        textColor: Colors.white,
                        iconColor: Colors.white,
                        text: 'Continue',
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Divider(),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    LoginOptions(icon: FontAwesomeIcons.google, onTap: () { controller.googleSignIn(); },),
                    const SizedBox(width: 20,),
                    LoginOptions(icon: FontAwesomeIcons.apple, onTap: () {},),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
