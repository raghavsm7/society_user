import 'dart:io';
import 'package:fl_sevengen_society_user_app/localization/localization_const.dart';
import 'package:fl_sevengen_society_user_app/screens/bottombar/controller/bottom_bar_controller.dart';
import 'package:fl_sevengen_society_user_app/screens/home/page/home.dart';
import 'package:fl_sevengen_society_user_app/screens/post_listing/page/post_listing_page.dart';
import 'package:fl_sevengen_society_user_app/screens/profile/profile.dart';
import 'package:fl_sevengen_society_user_app/screens/services/services.dart';
import 'package:fl_sevengen_society_user_app/theme/theme.dart';
import 'package:fl_sevengen_society_user_app/widgets/async_call_parent_widget.dart';
import 'package:fl_sevengen_society_user_app/widgets/base_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ep.dart';
import 'package:iconify_flutter/icons/fluent_mdl2.dart';
import 'package:iconify_flutter/icons/mdi.dart';
import 'package:iconify_flutter/icons/ri.dart';

class BottomBarPage extends BaseWidget {
  DateTime? backPressTime;

  final sendMessage = [
    {
      "image": "assets/home/system-administrator.png",
      "name": "Admin",
    },
    {
      "image": "assets/home/police.png",
      "name": "Security",
    },
  ];

  final securityAlert = [
    {
      "image": "assets/home/fire-extinguisher.png",
      "name": "Fire Alert",
    },
    {
      "image": "assets/home/elevator.png",
      "name": "Stuck in Lift",
    },
    {
      "image": "assets/home/dinosaur.png",
      "name": "Animal Threat",
    },
    {
      "image": "assets/home/terrorist.png",
      "name": "Visiter Threat",
    },
  ];

  BottomBarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BottomBarController>(
        builder: (BottomBarController controller) {
      return ModalProgressHUD(
        inAsyncCall: controller.loading,
        child: WillPopScope(
          onWillPop: () async {
            bool backStatus = onWillPop(context);
            if (backStatus) {
              exit(0);
            } else {
              return false;
            }
          },
          child: Scaffold(
            extendBody: true,
            body: [
              HomePage(controller.authResponseModel),
              PostListingPage(),
              const ServiceScreen(),
              const ProfileScreen()
            ].elementAt(
                controller.selectedIndex) /*pages.elementAt(selectedIndex)*/,
            bottomNavigationBar: bottomBar(context, controller),
            //   floatingActionButton: floatingButton(context),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
          ),
        ),
      );
    });
  }

  bottomBar(BuildContext context, BottomBarController barController) {
    return BottomAppBar(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: const CircularNotchedRectangle(),
      notchMargin: 6.0,
      // elevation: 50.0,
      shadowColor: blackColor,
      child: BottomNavigationBar(
        onTap: (index) {
          if (barController.authResponseModel.data?.user?.verified == true) {
            barController.changeBottomBarTab(index);
          }
        },
        backgroundColor: whiteColor,
        selectedItemColor: primaryColor,
        unselectedItemColor: greyB4Color,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: semibold14Primary,
        unselectedLabelStyle: semibold14GreyB4,
        currentIndex: barController.selectedIndex,
        items: [
          itemWidget(Ri.home_4_line, getTranslate(context, 'bottom_bar.home')),
          itemWidget(Mdi.message_outline, getTranslate(context, 'Post')),
          itemWidget(
              FluentMdl2.repair, getTranslate(context, 'bottom_bar.service')),
          itemWidget(Ep.user, getTranslate(context, 'bottom_bar.profile'))
        ],
      ),
    );
  }

  floatingButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        securityAlertDialog(context);
      },
      elevation: 0,
      backgroundColor: primaryColor,
      child: const Icon(
        CupertinoIcons.checkmark_shield,
        size: 30.0,
      ),
    );
  }

  securityAlertDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return Align(
          alignment: Alignment.bottomCenter,
          child: Dialog(
            alignment: Alignment.bottomCenter,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            backgroundColor: const Color(0xFFE9F0F4),
            insetPadding: const EdgeInsets.fromLTRB(fixPadding * 4.0,
                fixPadding, fixPadding * 4.0, fixPadding * 10.0),
            child: ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.all(fixPadding * 2.0),
              physics: const BouncingScrollPhysics(),
              children: [
                Text(
                  getTranslate(context, 'bottom_bar.send_message'),
                  style: semibold16Primary,
                ),
                heightSpace,
                GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: fixPadding * 2.0,
                    crossAxisSpacing: fixPadding * 2.0,
                    childAspectRatio: 1.2,
                  ),
                  itemCount: sendMessage.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return gridListContent(
                        index,
                        sendMessage[index]['image'].toString(),
                        sendMessage[index]['name'].toString(), () {
                      Navigator.popAndPushNamed(context, '/message');
                    });
                  },
                ),
                heightSpace,
                heightSpace,
                Text(
                  getTranslate(context, 'bottom_bar.security_alert'),
                  style: semibold16Primary,
                ),
                heightSpace,
                GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: fixPadding * 2.0,
                    crossAxisSpacing: fixPadding * 2.0,
                    childAspectRatio: 1.2,
                  ),
                  itemCount: securityAlert.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return gridListContent(
                        index,
                        securityAlert[index]['image'].toString(),
                        securityAlert[index]['name'].toString(),
                        () {});
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  gridListContent(int index, String image, String name, Function() onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: shadowColor.withOpacity(0.25),
              blurRadius: 6.0,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              image,
              fit: BoxFit.cover,
              height: 40.0,
              width: 40.0,
            ),
            height5Space,
            Text(
              name,
              style: medium15Primary,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  itemWidget(String icon, String title) {
    return BottomNavigationBarItem(
      icon: Iconify(icon, color: greyB4Color),
      activeIcon: Iconify(icon, color: primaryColor),
      label: title,
    );
  }

  onWillPop(BuildContext context) {
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
