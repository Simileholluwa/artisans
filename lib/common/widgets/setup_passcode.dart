import 'package:artisans/common/widgets/create_passcode.dart';
import 'package:artisans/common/widgets/registration_progress.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_button.dart';

class SetupPasscode extends StatelessWidget {
  const SetupPasscode({Key? key}) : super(key: key);

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
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(FontAwesomeIcons.language),
                  splashRadius: 35,
                ),
                const SizedBox(width: 10),
              ],
              title: Text(
                'Setup passcode',
                style: GoogleFonts.poppins(fontSize: 17),
              ),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
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
                isActive3: true,
                isActive2: true,
                isActive4: true,
                isActive5: true,
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                children: [
                  Flexible(
                    child: Text(
                      'Secure your account',
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
                child: Text('Using a passcode adds an extra layer of security to your account and ensures only you can access your data',
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w300,
                      color: Theme.of(Get.context!).hintColor,
                      fontSize: 15
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: AppButton(
            onTap: (){
              createPasscode();
            },
            icon: Icons.arrow_forward,
            textColor: Colors.white,
            iconColor: Colors.white,
            text: 'Proceed to setup',
          ),
        ),
      ),
    );
  }
}
