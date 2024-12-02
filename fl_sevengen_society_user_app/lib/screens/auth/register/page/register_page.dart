import 'package:fl_sevengen_society_user_app/localization/localization_const.dart';
import 'package:fl_sevengen_society_user_app/screens/auth/register/controller/register_controller.dart';
import 'package:fl_sevengen_society_user_app/theme/theme.dart';
import 'package:fl_sevengen_society_user_app/widgets/async_call_parent_widget.dart';
import 'package:fl_sevengen_society_user_app/widgets/base_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterPage extends BaseWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegisterController>(
        builder: (RegisterController controller) {
      final size = MediaQuery.of(context).size;
      return ModalProgressHUD(
        inAsyncCall: controller.loading,
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                heightSpace,
                height5Space,
                backbutton(context),
                Expanded(
                  child: ListView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(
                        horizontal: fixPadding * 2.0),
                    children: [
                      registerText(context),
                      heightSpace,
                      pleaseText(context),
                      heightSpace,
                      heightSpace,
                      heightSpace,
                      heightSpace,
                      userNameField(context, controller),
                      heightSpace,
                      height5Space,
                      //phoneField(context,controller),
                      flatNumberField(context, controller),
                      heightSpace,
                      heightSpace,
                      societyCodeField(context, controller),
                      heightSpace,
                      heightSpace,
                      passwordCodeField(context, controller),
                      heightSpace,
                      heightSpace,
                      confirmPasswordCodeField(context, controller),
                      heightSpace,
                      heightSpace,
                      heightSpace,
                      heightSpace,
                      heightSpace,
                      height5Space,
                      registerButton(context, controller),
                      heightSpace,
                      heightSpace,
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      );
    });
  }

  pleaseText(BuildContext context) {
    return Text(
      getTranslate(context, 'register.please_text'),
      textAlign: TextAlign.center,
      style: medium14Grey77,
    );
  }

  registerText(BuildContext context) {
    return Text(
      getTranslate(context, 'register.REGISTER'),
      style: semibold21Primary,
      textAlign: TextAlign.center,
    );
  }

  registerButton(BuildContext context, RegisterController controller) {
    return GestureDetector(
      onTap: () {
        controller.actionOnSubmitClick(controller,context);
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
            ),
          ],
        ),
        alignment: Alignment.center,
        child: Text(
          getTranslate(context, 'register.register'),
          style: semibold18White,
        ),
      ),
    );
  }

  flatNumberField(BuildContext context, RegisterController registerController) {
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
        controller: registerController.flatNumberController,
        keyboardType: TextInputType.text,
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
              Icons.house_outlined,
              size: 20,
            ),
          ),
          hintText: getTranslate(context, 'Flat number'),
          hintStyle: medium16Grey,
        ),
      ),
    );
  }

  societyCodeField(
      BuildContext context, RegisterController registerController) {
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
        controller: registerController.societyCodeController,
        keyboardType: TextInputType.text,
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
              Icons.numbers,
              size: 20,
            ),
          ),
          hintText: getTranslate(context, 'Society code'),
          hintStyle: medium16Grey,
        ),
      ),
    );
  }

  passwordCodeField(
      BuildContext context, RegisterController registerController) {
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
        controller: registerController.passwordController,
        keyboardType: TextInputType.text,
        obscureText: registerController.isPasswordVisible,
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
                registerController.checkIsPasswordVisible();
              },
              child: (registerController.isPasswordVisible)
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

  confirmPasswordCodeField(
      BuildContext context, RegisterController registerController) {
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
        keyboardType: TextInputType.text,
        obscureText: registerController.isConfirmPasswordVisible,
        controller: registerController.confirmPasswordController,
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
                registerController.checkIsConfirmPasswordVisible();
              },
              child: (registerController.isConfirmPasswordVisible)
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
          hintText: getTranslate(context, 'Enter confirm password'),
          hintStyle: medium16Grey,
        ),
      ),
    );
  }

  //phone number field
  phoneField(BuildContext context, RegisterController registerController) {
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
        keyboardType: TextInputType.visiblePassword,
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
                      )),
            alignment: Alignment.center,
            child: const Icon(
              Icons.phone_android,
              size: 20,
            ),
          ),
          hintText: getTranslate(context, 'Enter confirm password'),
          hintStyle: medium16Grey,
        ),
      ),
    );
  }

  userNameField(BuildContext context, RegisterController registerController) {
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
        controller: registerController.userNameController,
        keyboardType: TextInputType.name,
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
              CupertinoIcons.person,
              size: 20,
            ),
          ),
          hintText: getTranslate(context, 'register.user_name'),
          hintStyle: medium16Grey,
        ),
      ),
    );
  }

  backbutton(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.pop(context);
      },
      padding: const EdgeInsets.all(fixPadding * 2.0),
      icon: const Icon(
        Icons.arrow_back,
        color: black33Color,
      ),
    );
  }
}
