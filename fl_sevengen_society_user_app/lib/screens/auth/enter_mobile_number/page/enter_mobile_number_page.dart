import 'dart:io';
import 'package:fl_sevengen_society_user_app/localization/localization_const.dart';
import 'package:fl_sevengen_society_user_app/route/app_routes.dart';
import 'package:fl_sevengen_society_user_app/screens/auth/enter_mobile_number/controller/enter_mobile_number_controller.dart';
import 'package:fl_sevengen_society_user_app/theme/theme.dart';
import 'package:fl_sevengen_society_user_app/widgets/async_call_parent_widget.dart';
import 'package:fl_sevengen_society_user_app/widgets/base_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class EnterMobileNumberPage extends BaseWidget {
  DateTime? backPressTime;

  EnterMobileNumberPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EnterMobileNumberController>(
        builder: (EnterMobileNumberController controller) {
      final size = MediaQuery.of(context).size;
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
            body: Container(
              height: size.height,
              width: size.width,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/auth/bg.png"),
                  fit: BoxFit.fill,
                ),
              ),
              child: ListView(
                padding: const EdgeInsets.all(fixPadding * 2.0),
                physics: const BouncingScrollPhysics(),
                children: [
                  heightBox(fixPadding * 6),
                  loginTitle(context),
                  heightSpace,
                  pleaseText(context),
                  heightSpace,
                  heightSpace,
                  heightSpace,
                  heightSpace,
                  phoneField(context, controller),
                  height5Space,
                  verificationText(context),
                  heightSpace,
                  heightSpace,
                  heightSpace,
                  heightSpace,
                  heightSpace,
                  height5Space,
                  loginButton(context, controller),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  loginButton(BuildContext context, EnterMobileNumberController controller) {
    return GestureDetector(
      onTap: () {
        controller.actionOnSubmitClick();
      },
      child: Container(
        width: double.maxFinite,
        padding: const EdgeInsets.symmetric(
            horizontal: fixPadding * 2.0, vertical: fixPadding * 1.4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: primaryColor,
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
          getTranslate(context, /* 'login.login'*/ 'Submit'),
          style: semibold18White,
        ),
      ),
    );
  }

  verificationText(BuildContext context) {
    return Text(
      getTranslate(context, 'login.verification_text'),
      style: medium14Primary,
    );
  }

  phoneField(BuildContext context, EnterMobileNumberController controller) {
    return Container(
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: blackColor.withOpacity(0.1),
            blurRadius: 12.0,
            offset: const Offset(0, 6),
          )
        ],
      ),
      child: IntlPhoneField(
        cursorColor: primaryColor,
        style: semibold16Black33,
        initialCountryCode: "IN",
        controller: controller.phoneNumberController,
        dropdownIconPosition: IconPosition.trailing,
        dropdownIcon: const Icon(
          Icons.keyboard_arrow_down_outlined,
          color: blackColor,
        ),
        textAlign: languageValue == 4 ? TextAlign.right : TextAlign.left,
        flagsButtonPadding:
            const EdgeInsets.symmetric(horizontal: fixPadding * 0.8),
        disableLengthCheck: true,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: getTranslate(context, 'login.enter_mobile_number'),
          hintStyle: medium16Grey,
        ),
      ),
    );
  }

  pleaseText(BuildContext context) {
    return Text(
      getTranslate(context, 'login.please_text'),
      style: medium14Grey77,
      textAlign: TextAlign.center,
    );
  }

  loginTitle(BuildContext context) {
    return Text(
      getTranslate(context, /*'login.LOGIN*/ 'Enter mobile number'),
      style: semibold21Primary,
      textAlign: TextAlign.center,
    );
  }

  onWillPop(BuildContext context) {
    Get.offAllNamed(Routes.login);
    /*DateTime now = DateTime.now();
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
    }*/
  }
}
