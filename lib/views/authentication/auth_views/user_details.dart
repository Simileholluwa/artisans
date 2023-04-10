import 'package:artisans/views/authentication/controller.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../../../common/widgets/widgets.dart';

class UserDetails extends GetView<AuthController> {
  const UserDetails({Key? key}) : super(key: key);

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
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(20.0),
            child: AppButton(
              onTap: () {
                final isValid =
                    controller.state.formKeyUser.currentState!.validate();
                if (!isValid) {
                  return;
                } else {
                  controller.state.formKeyUser.currentState!.save();
                  controller.addUserData(
                    Get.arguments["isPhone"] == false
                        ? null
                        : controller.state.emailController.text.trim(),
                    controller.state.fullNameController.text.trim(),
                    controller.state.photo == null
                        ? Get.arguments['photoUrl']
                        : controller.state.urlDownload.value,
                    controller.state.countries.value.name,
                    Get.arguments["isPhone"] == false
                        ? "+${controller.state.countries.value.phoneCode}${controller.state.phoneNumberController.text.trim()}"
                        : null,
                    controller.state.ninController.text.trim(),
                  );
                }
              },
              icon: FontAwesomeIcons.solidPaperPlane,
              textColor: Colors.white,
              iconColor: Colors.white,
              text: 'Continue',
            ),
          ),
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
                  'Finish signing up',
                  style: Theme.of(context).textTheme.bodyLarge!,
                ),
              ),
            ),
          ),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.only(
                left: 20.0,
                right: 20,
                top: 30,
                bottom: 20,
              ),
              child: Column(
                children: [
                  GetBuilder<AuthController>(
                    builder: (_) {
                      return Material(
                        type: MaterialType.transparency,
                        borderRadius: BorderRadius.circular(75),
                        child: InkWell(
                          onTap: () {
                            controller.imgFromGallery();
                          },
                          borderRadius: BorderRadius.circular(75),
                          child: Ink(
                            height: 150,
                            width: 150,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Theme.of(context).cardColor,
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(75),
                              child: controller.state.photoPicked.isFalse
                                  ? Image.network(
                                      Get.arguments['photoUrl'],
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, exception, starkTrace) {
                                        return Icon(
                                          CupertinoIcons.person_alt_circle,
                                          size: 150,
                                          color: Theme.of(context).hintColor,
                                        );
                                      },
                                      loadingBuilder:
                                          (context, child, loadingProgress) {
                                        if (loadingProgress == null) {
                                          return child;
                                        }
                                        return Center(
                                          child: LoadingAnimationWidget
                                              .prograssiveDots(
                                            color: Colors.blue,
                                            size: 50,
                                          ),
                                        );
                                      },
                                    )
                                  : Image.file(
                                      controller.state.photo!,
                                      fit: BoxFit.cover,
                                    ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Tap on the image above to choose an image that clearly shows your face if the one displayed does not.',
                    style: Theme.of(context).textTheme.bodySmall,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Form(
                    key: controller.state.formKeyUser,
                    child: Column(
                      children: [
                        CustomTextField(
                          addBorder: false,
                          filled: true,
                          onSaved: (value) {
                            controller.state.fullNameController.text = value!;
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter your full name";
                            } else {
                              return null;
                            }
                          },
                          inputAction: TextInputAction.done,
                          textInputType: TextInputType.text,
                          controller: controller.state.fullNameController,
                          prefixIcon: Padding(
                            padding: const EdgeInsets.only(
                              right: 10.0,
                              left: 1,
                            ),
                            child: Material(
                              type: MaterialType.transparency,
                              borderRadius: BorderRadius.circular(10),
                              child: Ink(
                                height: 62,
                                width: 62,
                                decoration: BoxDecoration(
                                  color: Colors.blue,
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
                                        Icons.person,
                                        color: Colors.white,
                                        size: 35,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          hintText: 'First and last name',
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
                                  'Make sure it is as it appears on your National ID card or slip.',
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
                          height: 20,
                        ),
                        CustomTextField(
                          addBorder: false,
                          filled: true,
                          onSaved: (value) {
                            Get.arguments["isPhone"] == false
                                ? controller.state.phoneNumberController.text =
                                    value!
                                : controller.state.emailController.text =
                                    value!;
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return Get.arguments["isPhone"] == false
                                  ? "Please enter your phone number"
                                  : "Please enter your email address";
                            } else if (!GetUtils.isEmail(value)) {
                              return Get.arguments["isPhone"] == true
                                  ? "Please enter a valid email address"
                                  : null;
                            } else {
                              return null;
                            }
                          },
                          inputFormatter: [
                            Get.arguments["isPhone"] == false
                                ? FilteringTextInputFormatter('.', allow: false)
                                : FilteringTextInputFormatter('', allow: false),
                            FilteringTextInputFormatter(' ', allow: false)
                          ],
                          inputAction: TextInputAction.done,
                          textInputType: Get.arguments["isPhone"] == false
                              ? TextInputType.number
                              : TextInputType.emailAddress,
                          controller: Get.arguments["isPhone"] == false
                              ? controller.state.phoneNumberController
                              : controller.state.emailController,
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
                                onTap: Get.arguments["isPhone"] == false
                                    ? () {
                                        showCountryPicker(
                                          context: context,
                                          onSelect: (value) {
                                            controller.state.countries.value =
                                                value;
                                          },
                                          countryListTheme:
                                              CountryListThemeData(
                                            backgroundColor: Theme.of(context)
                                                .scaffoldBackgroundColor,
                                            borderRadius:
                                                const BorderRadius.only(
                                              topLeft: Radius.circular(15),
                                              topRight: Radius.circular(15),
                                            ),
                                            inputDecoration: InputDecoration(
                                              prefixIcon:
                                                  const Icon(Icons.search),
                                              hintText: 'Search',
                                              filled: false,
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                borderSide: const BorderSide(
                                                  color: Colors.blue,
                                                ),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                borderSide: const BorderSide(
                                                  color: Colors.blue,
                                                  width: 2.0,
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      }
                                    : () {},
                                child: Ink(
                                  height: 62,
                                  width: 62,
                                  decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      left: 5,
                                      right: 5,
                                      bottom: 1,
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Get.arguments["isPhone"] == false
                                            ? Text(
                                                '+${controller.state.countries.value.phoneCode}',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge!
                                                    .copyWith(
                                                      color: Colors.white,
                                                    ),
                                              )
                                            : const Icon(
                                                Icons.mail,
                                                color: Colors.white,
                                                size: 35,
                                              ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          hintText: Get.arguments["isPhone"] == false
                              ? 'Mobile number'
                              : 'Email address',
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
                                  Get.arguments["isPhone"] == false
                                      ? 'A verification code will be sent to verify your mobile number. Enter the code in the next screen.'
                                      : 'Follow the link that will be sent to the email address provided to verify your email.',
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
                          height: 20,
                        ),
                        CustomTextField(
                          addBorder: false,
                          filled: true,
                          onSaved: (value) {
                            controller.state.ninController.text = value!;
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter your NIN";
                            } else {
                              return null;
                            }
                          },
                          inputFormatter: [
                            FilteringTextInputFormatter('.', allow: false)
                          ],
                          inputAction: TextInputAction.done,
                          textInputType: TextInputType.number,
                          controller: controller.state.ninController,
                          prefixIcon: Padding(
                            padding: const EdgeInsets.only(
                              right: 10.0,
                              left: 1,
                            ),
                            child: Material(
                              type: MaterialType.transparency,
                              borderRadius: BorderRadius.circular(10),
                              child: Ink(
                                height: 62,
                                width: 62,
                                decoration: BoxDecoration(
                                  color: Colors.blue,
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
                                        FontAwesomeIcons.idCard,
                                        color: Colors.white,
                                        size: 30,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          hintText: 'National Identification Number (NIN)',
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
                                  'Your NIN will be used to verify your identity and the information you have provided.',
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
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
