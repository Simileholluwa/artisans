import 'package:artisans/views/authentication/controller.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../common/widgets/widgets.dart';

class FullName extends GetView<AuthController> {
  const FullName({Key? key}) : super(key: key);

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
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: AppButton(
            onTap: () {
              final isValid =
              controller.state.formKeyFullName.currentState!.validate();
              if (!isValid) {
                return;
              } else {
                controller.updateProfileImageAndName();
              }
            },
            icon: Icons.arrow_forward,
            iconColor: Colors.white,
            text: 'Next',
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
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(FontAwesomeIcons.language),
                  splashRadius: 35,
                ),
                const SizedBox(width: 10),
              ],
              title: Text(
                'Choose an Artisan ID',
                style: GoogleFonts.poppins(fontSize: 17),
              ),
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
                  isActive3: true,
                  isActive4: true,
                ),
                const SizedBox(
                  height: 40,
                ),
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        'Be distinct and unique',
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
                    style: GoogleFonts.poppins(fontWeight: FontWeight.w400, fontSize: 15, color: Theme.of(context).hintColor),
                    children: <TextSpan>[
                      const TextSpan(
                        text: 'An '
                      ),
                      TextSpan(
                          text: 'Artisan ID ', style: GoogleFonts.poppins(fontWeight: FontWeight.w700),
                      ),
                      const TextSpan(
                          text: 'uniquely identifies you on the Artisan app for making and receiving payments.'
                      ),
                    ],

                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Form(
                  key: controller.state.formKeyFullName,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    children: [
                      CustomTextField(
                        addBorder: false,
                        filled: true,
                        onSaved: (value) {
                          controller.state.fullNameController.text = value!;
                        },
                        validator: (value) {
                          if (value!.length < 3) {
                            return "ID should be more than two letters";
                          }
                          else if(value.isEmpty){
                            return "Please enter a unique ID";
                          } else if (value.length >= 3) {
                            for (var name in controller.state.username) {
                              if(name.toString().toLowerCase() == value.toString().toLowerCase()) {
                                return "ID already exist";
                              }
                            }
                          }
                          return null;
                        },
                        inputAction: TextInputAction.done,
                        textInputType: TextInputType.text,
                        controller: controller.state.fullNameController,
                        inputFormatter: [
                          FilteringTextInputFormatter(' ', allow: false)
                        ],
                        prefixIcon: Padding(
                          padding: const EdgeInsets.only(
                            right: 10.0,
                            left: 1,
                          ),
                          child: Material(
                            type: MaterialType.transparency,
                            borderRadius: BorderRadius.circular(10),
                            child: Ink(
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
                                      FontAwesomeIcons.at,
                                      color: Colors.white,
                                      size: 30,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        hintText: 'Artisan ID',
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
