import 'package:artisans/common/routes/routes.dart';
import 'package:artisans/common/services/services.dart';
import 'package:artisans/common/store/store.dart';
import 'package:artisans/common/utils/retrieve_passcode.dart';
import 'package:artisans/common/widgets/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class UnlockApp extends StatelessWidget {
  const UnlockApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RxBool _isLoading = false.obs;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: FlexColorScheme.themedSystemNavigationBar(
        context,
        systemNavBarStyle: FlexSystemNavBarStyle.scaffoldBackground,
        useDivider: false,
        opacity: 1,
      ),
      child: OnAppExit(
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
                  'Unlock your account',
                  style: GoogleFonts.poppins(fontSize: 17),
                ),
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(
                        top: 40,
                        bottom: 20,
                      ),
                      height: 100,
                      width: 100,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                        image: AssetImage('assets/images/locked.png'),
                        fit: BoxFit.cover,
                      )),
                    ),
                  ],
                ),
                RichText(
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  text: TextSpan(
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        fontSize: 25,
                        color: Theme.of(Get.context!).hintColor),
                    children: <TextSpan>[
                      const TextSpan(text: 'Welcome back, '),
                      TextSpan(
                        text: FirebaseAuth.instance.currentUser?.displayName ??
                            '',
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w700,
                            color: Theme.of(Get.context!).iconTheme.color),
                      ),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () {
                    UserStore.to.onLogout();
                    Get.offAllNamed(AppRoutes.auth);
                  },
                  child: RichText(
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    text: TextSpan(
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        color: Theme.of(Get.context!).hintColor,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text:
                              'Not ${FirebaseAuth.instance.currentUser?.displayName ?? ''}?',
                        ),
                        TextSpan(
                          text: ' Logout',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            color: Colors.blue.shade700,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Obx(
              () => AppButton(
                onTap: () async {
                  try {
                    _isLoading.value = true;
                    String correctString =
                        StorageService.to.getString('userPasscode') == ''
                            ? await retrievePasscode()!
                            : StorageService.to.getString('userPasscode');
                    lockScreen(correctString);
                    _isLoading.value = false;
                  } catch (e) {
                    _isLoading.value = false;
                    message(
                        'Unable to retrieve passcode. Ensure you have an active internet.');
                  }
                },
                icon: Icons.arrow_forward,
                iconColor: Colors.white,
                text: 'Unlock account',
                isLoading: _isLoading.isFalse ? false : true,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
