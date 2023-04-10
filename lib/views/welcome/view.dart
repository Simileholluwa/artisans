import 'package:artisans/common/routes/names.dart';
import 'package:artisans/views/welcome/controller.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../common/widgets/app_button.dart';

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
        body: Obx(
          () => Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 10,
                  bottom: 25,
                  left: 20,
                  right: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'artisan',
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .copyWith(fontSize: 50, color: Colors.pinkAccent),
                    ),
                    Text(
                        textAlign: TextAlign.center,
                        controller.state.artisanText,
                        style: Theme.of(context).textTheme.bodyMedium!),
                  ],
                ),
              ),
              const Spacer(),
              SizedBox(
                height: 650,
                child: Column(
                  children: [
                    SizedBox(
                      height: 580,
                      child: PageView(
                        controller: PageController(
                          keepPage: false,
                        ),
                        physics: const ClampingScrollPhysics(),
                        onPageChanged: (index) {
                          controller.changePage(index);
                        },
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Column(
                              children: [
                                Container(
                                  height: 500,
                                  width: double.maxFinite,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).cardColor,
                                    borderRadius: BorderRadius.circular(15),
                                    image: const DecorationImage(
                                        image: AssetImage(
                                            'assets/images/hero 1.jpg'),
                                        fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  'Need a service or product?',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                        fontSize: 25,
                                      ),
                                ),
                                Text(
                                    'Browse available gigs or post your specifics',
                                    style:
                                        Theme.of(context).textTheme.bodySmall!),
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Column(
                              children: [
                                Container(
                                  height: 500,
                                  width: double.maxFinite,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).cardColor,
                                    borderRadius: BorderRadius.circular(15),
                                    image: const DecorationImage(
                                        image: AssetImage(
                                            'assets/images/hero 2.jpg'),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  'Sell a service or product?',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                        fontSize: 25,
                                      ),
                                ),
                                Text(
                                    'Earn money by posting what you do or sell',
                                    style:
                                        Theme.of(context).textTheme.bodySmall!),
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Column(
                              children: [
                                Container(
                                  height: 500,
                                  width: double.maxFinite,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Theme.of(context).cardColor,
                                    image: const DecorationImage(
                                        image: AssetImage(
                                            'assets/images/hero 3.jpg'),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  'Looking for local talents?',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                        fontSize: 25,
                                      ),
                                ),
                                Text('Post your project and get proposals',
                                    style:
                                        Theme.of(context).textTheme.bodySmall!),
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Column(
                              children: [
                                Container(
                                  height: 500,
                                  width: double.maxFinite,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Theme.of(context).cardColor,
                                    image: const DecorationImage(
                                        image: AssetImage(
                                            'assets/images/hero 4.jpg'),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  'We are on a journey',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                        fontSize: 25,
                                      ),
                                ),
                                Text('But we can\'t do it without you',
                                    style:
                                        Theme.of(context).textTheme.bodySmall!),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    DotsIndicator(
                      position: controller.state.index.value.toDouble(),
                      dotsCount: 4,
                      reversed: false,
                      mainAxisAlignment: MainAxisAlignment.center,
                      decorator: DotsDecorator(
                        size: const Size.square(9),
                        activeSize: const Size(18, 9),
                        activeShape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 10.0,
                  left: 20,
                  right: 20,
                ),
                child: AppButton(
                  onTap: () => Get.toNamed(AppRoutes.auth),
                  textColor: Colors.white,
                  iconColor: Colors.white,
                  text: controller.state.buttonText,
                  icon: controller.state.buttonIcon,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
