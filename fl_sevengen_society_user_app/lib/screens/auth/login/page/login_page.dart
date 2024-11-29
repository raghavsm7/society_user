import 'dart:io';
import 'package:fl_sevengen_society_user_app/localization/localization_const.dart';
import 'package:fl_sevengen_society_user_app/route/app_routes.dart';
import 'package:fl_sevengen_society_user_app/screens/auth/login/controller/login_controller.dart';
import 'package:fl_sevengen_society_user_app/theme/theme.dart';
import 'package:fl_sevengen_society_user_app/widgets/async_call_parent_widget.dart';
import 'package:fl_sevengen_society_user_app/widgets/base_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class LogInPage extends BaseWidget {
  DateTime? backPressTime;

  LogInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LogInController>(builder: (LogInController controller) {
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
                  height5Space,
                  height5Space,
                  passwordCodeField(context, controller),
                  heightSpace,
                  heightSpace,
                  heightSpace,
                  heightSpace,
                  dontHaveAccount(context),
                  // verificationText(context),
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

  loginButton(BuildContext context, LogInController controller) {
    return GestureDetector(
      onTap: () {
        controller.actionOnTheClickOfSubmitButton(controller, context);
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

  phoneField(BuildContext context, LogInController controller) {
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

  passwordCodeField(BuildContext context, LogInController logInController) {
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
          ),
        ],
      ),
      child: TextField(
        cursorColor: primaryColor,
        style: semibold16Black33,
        controller: logInController.passwordController,
        keyboardType: TextInputType.text,
        obscureText: logInController.isPasswordVisible,
        decoration: InputDecoration(
          border: InputBorder.none,
          prefixIconConstraints: const BoxConstraints(maxWidth: 60),
          prefixIcon: Container(
            width: 60.0,
            margin: languageValue == 4
                ? const EdgeInsets.only(left: 15.0)
                : const EdgeInsets.only(right: 15.0),
            decoration: BoxDecoration(
              border: languageValue == 4
                  ? const Border(
                      left: BorderSide(color: greyColor, width: 1.5),
                    )
                  : const Border(
                      right: BorderSide(color: greyColor, width: 1.5),
                    ),
            ),
            alignment: Alignment.center,
            child: const Icon(
              Icons.password,
              size: 20,
            ),
          ),
          suffixIcon: Container(
            width: 60.0,
            margin: languageValue == 4
                ? const EdgeInsets.only(left: 15.0)
                : const EdgeInsets.only(right: 15.0),
            alignment: Alignment.center,
            child: InkWell(
              onTap: () {
                logInController.checkIsPasswordVisible();
              },
              child: (logInController.isPasswordVisible)
                  ? const Icon(
                      Icons.visibility_off_outlined,
                      size: 20,
                    )
                  : const Icon(
                      Icons.visibility_outlined,
                      size: 20,
                    ),
            ),
          ),
          hintText: getTranslate(context, 'Enter password'),
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

  dontHaveAccount(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          getTranslate(context, 'Don\'t have account?'),
          style: semibold15Primary,
          textAlign: TextAlign.center,
        ),
        InkWell(
          onTap: () {
            Get.toNamed(Routes.enterMobileNumber);
          },
          child: Text(
            getTranslate(context, ' Register'),
            style: semibold15Primary,
            textAlign: TextAlign.center,
          ),
        )
      ],
    );
  }

  loginTitle(BuildContext context) {
    return Text(
      getTranslate(context, /*'login.LOGIN*/ 'LOGIN'),
      style: semibold21Primary,
      textAlign: TextAlign.center,
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
