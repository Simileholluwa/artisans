import 'package:artisans/views/welcome/controller.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../common/widgets/widgets.dart';

class Welcome extends GetView<WelcomeController> {
  const Welcome({Key? key}) : super(key: key);

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
        appBar: AppBar(
          toolbarHeight: 0,
          scrolledUnderElevation: 0,
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(
            bottom: 10,
            left: 20,
            right: 20,
          ),
          child: Obx(() => AppButton(
            onTap: () {
              controller.state.index.value != 3
                  ? controller.changeIndex()
                  : controller.openAuthScreen();
            },
            textColor: Colors.white,
            iconColor: Colors.white,
            text: controller.state.btnText.value,
            icon: controller.state.icon.value,
          ),),
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 40,
                  left: 20,
                  right: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'artisan',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.sacramento(
                            fontSize: 100,
                            color: Colors.pinkAccent,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Obx(
                  () => Column(
                    children: [
                      Offerings(
                        isFirst: true,
                        opacity: controller.state.opacity.value,
                        heading: 'Need a service or product?',
                        subHeading:
                            'Effortlessly locate the best talent for your services on demand, and within your locality.',
                        image: 'dashboard.png',
                      ),
                      Offerings(
                        opacity: controller.state.opacity1.value,
                        heading: 'Sell a service or product?',
                        subHeading:
                            'Give your skill or product a befitting visibility that can compete in the global market while earning.',
                        image: 'online-store.png',
                      ),
                      Offerings(
                        opacity: controller.state.opacity2.value,
                        heading: 'Looking for local talents?',
                        subHeading:
                            'Post your project, get proposals, choose from a pool of proposals and hire the best fit.',
                        image: 'team.png',
                      ),
                      Offerings(
                        opacity: controller.state.opacity3.value,
                        heading: 'We are on a mission',
                        subHeading:
                            'We aim to expose the undiscovered potential of the Nigerian people to the world.',
                        image: 'release.png',
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
