import 'dart:async';
import 'package:fl_sevengen_society_user_app/localization/localization_const.dart';
import 'package:fl_sevengen_society_user_app/screens/auth/verify_otp/controller/verify_otp_controller.dart';
import 'package:fl_sevengen_society_user_app/theme/theme.dart';
import 'package:fl_sevengen_society_user_app/widgets/async_call_parent_widget.dart';
import 'package:fl_sevengen_society_user_app/widgets/base_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

class VerifyOtpPage extends BaseWidget {
  Timer? countdownTimer;
  Duration myDuration = const Duration(minutes: 2);
  String otpValue = "";

  VerifyOtpPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery
        .of(context)
        .size;
    String strDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = strDigits(myDuration.inMinutes.remainder(60));
    final seconds = strDigits(myDuration.inSeconds.remainder(60));

    return GetBuilder<VerifyOTPController>(
        builder: (VerifyOTPController controller) {
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
                          otpText(context),
                          heightSpace,
                          pleaseText(context, controller),
                          heightSpace,
                          heightSpace,
                          heightSpace,
                          heightSpace,
                          height5Space,
                          otpField(context, controller),
                          heightSpace,
                          heightSpace,
                          heightSpace,
                          heightSpace,
                          height5Space,
                          //timer(minutes, seconds),
                          heightSpace,
                          heightSpace,
                          height5Space,
                          verifyButton(context, controller),
                          heightSpace,
                          heightSpace,
                          height5Space,
                          resendText(context, controller),
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

  resendText(BuildContext context, VerifyOTPController verifyOTPController) {
    return Text.rich(
      TextSpan(
          text: getTranslate(context, 'otp.didnt_recived'),
          style: semibold15Primary,
          children: [
          const TextSpan(text: " "),
      TextSpan(
          style: semibold15Primary,
          text: getTranslate(
            context,
            'Resend',
          ),
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              verifyOTPController.otpController.clear();
              verifyOTPController.callResendOtpApi();
            }),
      ],
    ),textAlign
    :
    TextAlign
    .
    center
    ,
    );
  }

  verifyButton(BuildContext context, VerifyOTPController verifyOTPController) {
    return GestureDetector(
      onTap: () {
        /*Timer(const Duration(seconds: 3), () {
          verifyOTPController.stopTimer();
          Navigator.popAndPushNamed(context, '/bottomBar');
        });*/
        verifyOTPController.actionOnVerifyButtonClick(otpValue);

        // pleaseWaitDialog(context);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
            horizontal: fixPadding * 2.0, vertical: fixPadding * 1.5),
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
          getTranslate(context, 'otp.verify'),
          style: semibold18White,
        ),
      ),
    );
  }

  pleaseWaitDialog(BuildContext context) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          backgroundColor: whiteColor,
          insetPadding: const EdgeInsets.all(fixPadding * 4.0),
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: fixPadding * 2.0, vertical: fixPadding * 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CupertinoActivityIndicator(
                  color: primaryColor,
                  radius: 15,
                ),
                widthSpace,
                Text(
                  getTranslate(context, 'otp.please_wait'),
                  style: semibold18Primary,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  timer(minutes, seconds) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(
            horizontal: fixPadding * 1.5, vertical: fixPadding / 2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40.0),
          color: const Color(0xFFD6E9F5),
        ),
        child: Text(
          "$minutes:$seconds",
          style: regular16Black,
        ),
      ),
    );
  }

  otpField(BuildContext context, VerifyOTPController verifyOTPController) {
    return Pinput(
      controller: verifyOTPController.otpController,
      cursor: Container(
        height: 22,
        width: 2,
        color: primaryColor,
      ),
      onCompleted: (value) {
        otpValue = value;
        // verifyOTPController.actionOnVerifyButtonClick(value);
        /* Timer(const Duration(seconds: 3), () {
          verifyOTPController.stopTimer();
          Navigator.popAndPushNamed(context, '/bottomBar');
        });

        pleaseWaitDialog(context);*/
      },
      defaultPinTheme: PinTheme(
        height: 50.0,
        width: 50.0,
        margin: const EdgeInsets.symmetric(horizontal: fixPadding / 2),
        textStyle: medium20Black33,
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(5.0),
          boxShadow: [
            BoxShadow(
              color: greyColor.withOpacity(0.25),
              blurRadius: 6.0,
            )
          ],
        ),
      ),
    );
  }

  pleaseText(BuildContext context, VerifyOTPController controller) {
    return Text(
      getTranslate(
          context,
          /*'otp.please_text'*/
          'Please enter OTP we will sent to you on your mobile \n no +91 ${controller
              .dataModel.phoneNumber}'),
      textAlign: TextAlign.center,
      style: medium14Grey77,
    );
  }

  otpText(BuildContext context) {
    return Text(
      getTranslate(context, 'otp.OTP_VERIFICATION'),
      style: semibold21Primary,
      textAlign: TextAlign.center,
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
