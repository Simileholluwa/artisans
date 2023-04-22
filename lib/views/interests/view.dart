import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../common/widgets/widgets.dart';
import 'controller.dart';

class Interests extends GetView<InterestsController> {
  const Interests({Key? key}) : super(key: key);

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
          padding: const EdgeInsets.only(left: 20, bottom: 10, right: 20,),
          child: AppButton(
            onTap: () {
              controller.state.selectedInterests.length < 3 ? toastMessage('Select up to three interests') : controller.goToHome();
            },
            icon: FontAwesomeIcons.check,
            textColor: Colors.white,
            iconColor: Colors.white,
            text: 'Finish',
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
                'Select your interests',
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
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'What are you interested in?',
                    style: GoogleFonts.poppins(fontSize: 25, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Related products will be recommended according to your choice. Choose at least 3.',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w300,
                        color: Theme.of(context).hintColor
                    ),
                  ),
                ],
              ),
            ),
            const RegProgress(
              isActive1: true,
              isActive2: true,
              isActive3: true,
              isActive4: true,
              isActive5: true,
            ),
            const SizedBox(
              height: 20,
            ),
            TabBar(
              controller: controller.state.tabController,
                isScrollable: true,
                indicatorSize: TabBarIndicatorSize.label,
                tabs: [
                  Tab(child: Text('Information Technology')),
                  Tab(child: Text('Beauty & Wellness')),
                  Tab(child: Text('Construction')),
                  Tab(child: Text('Manufacturing')),
                  Tab(child: Text('Logistics')),
                  Tab(child: Text('Agriculture & Farming')),
                  Tab(child: Text('Engineering')),
                  Tab(child: Text('Hospitality')),
                ],
            ),
            Expanded(
              child: TabBarView(
                controller: controller.state.tabController,
                  children: [
                    ListView.separated(
                      itemCount: controller.state.interests.length,
                      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 20, top: 10,),
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      separatorBuilder: (context, index){
                        return const SizedBox(
                          height: 10,
                        );
                      },
                      itemBuilder: (context, index) {
                        return SuggestedInterests(
                          image: controller.state.interests[index].image,
                          interestName:
                          controller.state.interests[index].interestName,
                          isSelected: controller.state.interests[index].isSelected,
                          subCategory: controller.state.interests[index].subCategory,
                          onTap: () {
                            controller.state.interests[index].isSelected.value =
                            !controller.state.interests[index].isSelected.value;
                            if (controller.state.interests[index].isSelected.isTrue) {
                              controller.state.selectedInterests.add(
                                  controller.state.interests[index].interestName);
                            } else if (controller
                                .state.interests[index].isSelected.isFalse) {
                              controller.state.selectedInterests.removeWhere(
                                      (element) =>
                                  element ==
                                      controller
                                          .state.interests[index].interestName);
                            }
                          },
                        );
                      },
                    ),
                    ListView.separated(
                      itemCount: controller.state.interests.length,
                      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 20, top: 10,),
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      separatorBuilder: (context, index){
                        return const SizedBox(
                          height: 10,
                        );
                      },
                      itemBuilder: (context, index) {
                        return SuggestedInterests(
                          image: controller.state.interests[index].image,
                          interestName:
                          controller.state.interests[index].interestName,
                          isSelected: controller.state.interests[index].isSelected,
                          subCategory: controller.state.interests[index].subCategory,
                          onTap: () {
                            controller.state.interests[index].isSelected.value =
                            !controller.state.interests[index].isSelected.value;
                            if (controller.state.interests[index].isSelected.isTrue) {
                              controller.state.selectedInterests.add(
                                  controller.state.interests[index].interestName);
                            } else if (controller
                                .state.interests[index].isSelected.isFalse) {
                              controller.state.selectedInterests.removeWhere(
                                      (element) =>
                                  element ==
                                      controller
                                          .state.interests[index].interestName);
                            }
                          },
                        );
                      },
                    ),
                    ListView.separated(
                      itemCount: controller.state.interests.length,
                      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 20, top: 10,),
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      separatorBuilder: (context, index){
                        return const SizedBox(
                          height: 10,
                        );
                      },
                      itemBuilder: (context, index) {
                        return SuggestedInterests(
                          image: controller.state.interests[index].image,
                          interestName:
                          controller.state.interests[index].interestName,
                          isSelected: controller.state.interests[index].isSelected,
                          subCategory: controller.state.interests[index].subCategory,
                          onTap: () {
                            controller.state.interests[index].isSelected.value =
                            !controller.state.interests[index].isSelected.value;
                            if (controller.state.interests[index].isSelected.isTrue) {
                              controller.state.selectedInterests.add(
                                  controller.state.interests[index].interestName);
                            } else if (controller
                                .state.interests[index].isSelected.isFalse) {
                              controller.state.selectedInterests.removeWhere(
                                      (element) =>
                                  element ==
                                      controller
                                          .state.interests[index].interestName);
                            }
                          },
                        );
                      },
                    ),
                    ListView.separated(
                      itemCount: controller.state.interests.length,
                      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 20, top: 10,),
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      separatorBuilder: (context, index){
                        return const SizedBox(
                          height: 10,
                        );
                      },
                      itemBuilder: (context, index) {
                        return SuggestedInterests(
                          image: controller.state.interests[index].image,
                          interestName:
                          controller.state.interests[index].interestName,
                          isSelected: controller.state.interests[index].isSelected,
                          subCategory: controller.state.interests[index].subCategory,
                          onTap: () {
                            controller.state.interests[index].isSelected.value =
                            !controller.state.interests[index].isSelected.value;
                            if (controller.state.interests[index].isSelected.isTrue) {
                              controller.state.selectedInterests.add(
                                  controller.state.interests[index].interestName);
                            } else if (controller
                                .state.interests[index].isSelected.isFalse) {
                              controller.state.selectedInterests.removeWhere(
                                      (element) =>
                                  element ==
                                      controller
                                          .state.interests[index].interestName);
                            }
                          },
                        );
                      },
                    ),
                    ListView.separated(
                      itemCount: controller.state.interests.length,
                      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 20, top: 10,),
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      separatorBuilder: (context, index){
                        return const SizedBox(
                          height: 10,
                        );
                      },
                      itemBuilder: (context, index) {
                        return SuggestedInterests(
                          image: controller.state.interests[index].image,
                          interestName:
                          controller.state.interests[index].interestName,
                          isSelected: controller.state.interests[index].isSelected,
                          subCategory: controller.state.interests[index].subCategory,
                          onTap: () {
                            controller.state.interests[index].isSelected.value =
                            !controller.state.interests[index].isSelected.value;
                            if (controller.state.interests[index].isSelected.isTrue) {
                              controller.state.selectedInterests.add(
                                  controller.state.interests[index].interestName);
                            } else if (controller
                                .state.interests[index].isSelected.isFalse) {
                              controller.state.selectedInterests.removeWhere(
                                      (element) =>
                                  element ==
                                      controller
                                          .state.interests[index].interestName);
                            }
                          },
                        );
                      },
                    ),
                    ListView.separated(
                      itemCount: controller.state.interests.length,
                      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 20, top: 10,),
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      separatorBuilder: (context, index){
                        return const SizedBox(
                          height: 10,
                        );
                      },
                      itemBuilder: (context, index) {
                        return SuggestedInterests(
                          image: controller.state.interests[index].image,
                          interestName:
                          controller.state.interests[index].interestName,
                          isSelected: controller.state.interests[index].isSelected,
                          subCategory: controller.state.interests[index].subCategory,
                          onTap: () {
                            controller.state.interests[index].isSelected.value =
                            !controller.state.interests[index].isSelected.value;
                            if (controller.state.interests[index].isSelected.isTrue) {
                              controller.state.selectedInterests.add(
                                  controller.state.interests[index].interestName);
                            } else if (controller
                                .state.interests[index].isSelected.isFalse) {
                              controller.state.selectedInterests.removeWhere(
                                      (element) =>
                                  element ==
                                      controller
                                          .state.interests[index].interestName);
                            }
                          },
                        );
                      },
                    ),
                    ListView.separated(
                      itemCount: controller.state.interests.length,
                      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 20, top: 10,),
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      separatorBuilder: (context, index){
                        return const SizedBox(
                          height: 10,
                        );
                      },
                      itemBuilder: (context, index) {
                        return SuggestedInterests(
                          image: controller.state.interests[index].image,
                          interestName:
                          controller.state.interests[index].interestName,
                          isSelected: controller.state.interests[index].isSelected,
                          subCategory: controller.state.interests[index].subCategory,
                          onTap: () {
                            controller.state.interests[index].isSelected.value =
                            !controller.state.interests[index].isSelected.value;
                            if (controller.state.interests[index].isSelected.isTrue) {
                              controller.state.selectedInterests.add(
                                  controller.state.interests[index].interestName);
                            } else if (controller
                                .state.interests[index].isSelected.isFalse) {
                              controller.state.selectedInterests.removeWhere(
                                      (element) =>
                                  element ==
                                      controller
                                          .state.interests[index].interestName);
                            }
                          },
                        );
                      },
                    ),
                    ListView.separated(
                      itemCount: controller.state.interests.length,
                      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 20, top: 10,),
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      separatorBuilder: (context, index){
                        return const SizedBox(
                          height: 10,
                        );
                      },
                      itemBuilder: (context, index) {
                        return SuggestedInterests(
                          image: controller.state.interests[index].image,
                          interestName:
                          controller.state.interests[index].interestName,
                          isSelected: controller.state.interests[index].isSelected,
                          subCategory: controller.state.interests[index].subCategory,
                          onTap: () {
                            controller.state.interests[index].isSelected.value =
                            !controller.state.interests[index].isSelected.value;
                            if (controller.state.interests[index].isSelected.isTrue) {
                              controller.state.selectedInterests.add(
                                  controller.state.interests[index].interestName);
                            } else if (controller
                                .state.interests[index].isSelected.isFalse) {
                              controller.state.selectedInterests.removeWhere(
                                      (element) =>
                                  element ==
                                      controller
                                          .state.interests[index].interestName);
                            }
                          },
                        );
                      },
                    ),
                  ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
