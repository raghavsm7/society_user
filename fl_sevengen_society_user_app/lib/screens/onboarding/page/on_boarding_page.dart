import 'dart:io';

import 'package:fl_sevengen_society_user_app/localization/localization_const.dart';
import 'package:fl_sevengen_society_user_app/route/app_routes.dart';
import 'package:fl_sevengen_society_user_app/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  PageController pageController =
      PageController(initialPage: 0, viewportFraction: 1.0);

  DateTime? backPressTime;

  final pageList = [
    {
      "image": "assets/onboarding/onboarding1.png",
      "name": translate('onboarding.text_1'),
      "description":
          "Lorem ipsum dolor sit amet consectetur. Ilectusrhoncus morbi varius. Viverra morbi vehicula accumsan nam natoque. Dignissim at velit"
    },
    {
      "image": "assets/onboarding/onboarding2.png",
      "name": translate('onboarding.text_2'),
      "description":
          "Lorem ipsum dolor sit amet consectetur. Ilectusrhoncus morbi varius. Viverra morbi vehicula accumsan nam natoque. Dignissim at velit"
    },
    {
      "image": "assets/onboarding/onboarding3.png",
      "name": translate('onboarding.text_3'),
      "description":
          "Lorem ipsum dolor sit amet consectetur. Ilectusrhoncus morbi varius. Viverra morbi vehicula accumsan nam natoque. Dignissim at velit"
    },
  ];

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        bool backStatus = onWillPop();
        if (backStatus) {
          exit(0);
        } else {
          return false;
        }
      },
      child: Scaffold(
        body: ListView(
          padding: EdgeInsets.zero,
          physics: const BouncingScrollPhysics(),
          children: [
            SizedBox(
              height: size.height,
              width: size.width,
              child: Stack(
                children: [
                  bgImage(size),
                  pageListContent(size),
                  indicator(size),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  pageListContent(Size size) {
    return SizedBox(
      height: size.height,
      width: size.width,
      child: Column(
        children: [
          Expanded(
            child: PageView(
              controller: pageController,
              onPageChanged: (index) {
                setState(() {
                  selectedIndex = index;
                });
              },
              children: List.generate(
                pageList.length,
                (index) => Column(
                  children: [
                    Container(
                      height: size.height * 0.5,
                      padding: const EdgeInsets.only(top: fixPadding * 2.0),
                      width: double.maxFinite,
                      color: const Color(0xFFEEF7FE),
                      alignment: Alignment.center,
                      child: Image.asset(
                        pageList[index]['image'].toString(),
                        fit: BoxFit.cover,
                        width: index == pageList.length - 1
                            ? double.maxFinite
                            : size.width - 80,
                      ),
                    ),
                    heightBox(fixPadding * 8.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: fixPadding * 2.0),
                      child: Text(
                        pageList[index]['name'].toString(),
                        style: semibold21Black4F,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    heightSpace,
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
                      child: Text(
                        "Lorem ipsum dolor sit amet consectetur. Ilectusrhoncus morbi varius. Viverra morbi vehicula accumsan nam natoque. Dignissim at velit",
                        style: medium14Grey,
                        textAlign: TextAlign.center,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          selectedIndex == pageList.length - 1
              ? getStaredButton()
              : nextButton(),
          heightBox(size.height * 0.13),
        ],
      ),
    );
  }

  bgImage(Size size) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Image.asset(
        "assets/splash/image.png",
        height: size.height * 0.35,
        width: double.maxFinite,
        fit: BoxFit.cover,
        opacity: const AlwaysStoppedAnimation(0.1),
      ),
    );
  }

  getStaredButton() {
    return GestureDetector(
      onTap: () {
        Get.toNamed(Routes.login);
      },
      child: Container(
        width: double.maxFinite,
        margin: const EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
        padding: const EdgeInsets.symmetric(
            horizontal: fixPadding * 2.0, vertical: fixPadding * 1.4),
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: primaryColor.withOpacity(0.1),
              blurRadius: 12.0,
              offset: const Offset(0, 6),
            )
          ],
        ),
        alignment: Alignment.center,
        child: Text(
          getTranslate(context, 'onboarding.get_started'),
          style: semibold18White,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  nextButton() {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex++;
          pageController.animateToPage(selectedIndex,
              duration: const Duration(milliseconds: 350),
              curve: Curves.easeIn);
        });
      },
      child: Container(
        width: double.maxFinite,
        margin: const EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
        padding: const EdgeInsets.symmetric(
            horizontal: fixPadding * 2.0, vertical: fixPadding * 1.4),
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: primaryColor.withOpacity(0.1),
              blurRadius: 12.0,
              offset: const Offset(0, 6),
            )
          ],
        ),
        alignment: Alignment.center,
        child: Text(
          getTranslate(context, 'onboarding.next'),
          style: semibold18White,
        ),
      ),
    );
  }

  indicator(Size size) {
    return Positioned(
      top: (size.height * 0.5) + 35,
      left: 0,
      right: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          pageList.length,
          (index) => Container(
            height: 9.5,
            width: 9.5,
            margin: const EdgeInsets.symmetric(horizontal: fixPadding / 3.5),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: selectedIndex == index ? primaryColor : greyD9Color,
            ),
          ),
        ),
      ),
    );
  }

  onWillPop() {
    DateTime now = DateTime.now();
    if (backPressTime == null ||
        now.difference(backPressTime!) >= const Duration(seconds: 2)) {
      backPressTime = now;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: blackColor,
          content: Text(
            getTranslate(context, 'exit_app.exit_text'),
            style: semibold15White,
          ),
          behavior: SnackBarBehavior.floating,
          duration: const Duration(milliseconds: 1500),
        ),
      );
      return false;
    } else {
      return true;
    }
  }
}
