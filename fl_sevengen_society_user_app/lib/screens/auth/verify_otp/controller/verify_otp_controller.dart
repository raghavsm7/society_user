import 'dart:async';

import 'package:fl_sevengen_society_user_app/common/data/model/common_response_model.dart';
import 'package:fl_sevengen_society_user_app/controller/base_controller.dart';
import 'package:fl_sevengen_society_user_app/enums/app_enums.dart';
import 'package:fl_sevengen_society_user_app/route/app_routes.dart';
import 'package:fl_sevengen_society_user_app/screens/auth/data/model/data_model.dart';
import 'package:fl_sevengen_society_user_app/screens/auth/data/provider/auth_provider.dart';
import 'package:fl_sevengen_society_user_app/utils/app_utils.dart';
import 'package:fl_sevengen_society_user_app/utils/app_validator.dart';
import 'package:fl_sevengen_society_user_app/utils/network_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';

class VerifyOTPController extends BaseController {
  String otp = "";
  late DataModel dataModel;
  TextEditingController otpController = TextEditingController();

  Timer? countdownTimer;
  Duration myDuration = const Duration(minutes: 2);

  @override
  void onInit() {
    super.onInit();
    dataModel = Get.arguments;
  }


 /* void startTimer() {
    countdownTimer =
        Timer.periodic(const Duration(seconds: 1), (_) => setCountDown());
  }

  void stopTimer() {
    countdownTimer!.cancel();
  }

  void resetTimer() {
    stopTimer();
    myDuration = const Duration(minutes: 2);
  }

  void setCountDown() {
    const reduceSecondsBy = 1;
    if (isClosed) {
      final seconds = myDuration.inSeconds - reduceSecondsBy;
      if (seconds < 0) {
        countdownTimer!.cancel();
      } else {
        myDuration = Duration(seconds: seconds);
      }
    }
  }*/

  //method call on the tap of verify button
  void actionOnVerifyButtonClick(String otpValue) {
    print("The OTP is $otpValue");
    bool result =
        AppValidator.appValidatorInstance.checkValidOTP(otpValue.trim());
    if (result == true) {
      NetworkUtils.networkUtilsInstance.getConnectivityStatus().then((value) {
        if (value == true) {
          _callVerifyOtpApi(otpValue);
        }
      });
    } else {
      // show validation error
      AppUtils.appUtilsInstance.setSnackBarType(
          isError: true,
          message:
              "Please enter a valid four digit OTP sent on your phone number");
    }
  }

  //method to call verify OTP API
  Future<void> _callVerifyOtpApi(String otpValue) async {
    AuthProvider authProvider = Get.find<AuthProvider>();

    AppUtils.appUtilsInstance.hideKeyboard();

    updateLoading(value: true);

    var apiResult = await authProvider.callVerifyOTPApi(
        phoneNumber: dataModel.phoneNumber, otp: otpValue);

    if (apiResult is CommonResponseModel) {
      // some error
      if (apiResult.statusCode == HttpStatus.ok) {
        // navigate to verify otp screen
        Get.toNamed(Routes.register,
            arguments: DataModel(
                phoneNumber: dataModel.phoneNumber,
                navigationEnums: OTPNavigationEnums.fromVerifyOTP));
        updateLoading();
      } else {
        updateLoading();
        AppUtils.appUtilsInstance.setSnackBarType(
            isError: true,
            message: apiResult.message ?? "Something went wrong");
      }
    } else {
      updateLoading();
      AppUtils.appUtilsInstance
          .setSnackBarType(isError: true, message: "Something went wrong");
    }
  }

  //method to call resend OTP API on the click of resend button
  Future<void> callResendOtpApi() async {
    AuthProvider authProvider = Get.find<AuthProvider>();

    AppUtils.appUtilsInstance.hideKeyboard();

    updateLoading(value: true);

    var apiResult = await authProvider.callSendOTPApi(
        phoneNumber: dataModel.phoneNumber.trim());

    if (apiResult is CommonResponseModel) {
      // some error
      if (apiResult.statusCode == HttpStatus.ok) {
        AppUtils.appUtilsInstance.setSnackBarType(
            isError: false, message: apiResult.message ?? "Success!!");
        updateLoading();
      } else {
        updateLoading();
        AppUtils.appUtilsInstance.setSnackBarType(
            isError: true,
            message: apiResult.message ?? "Something went wrong");
      }
    } else {
      updateLoading();
      AppUtils.appUtilsInstance
          .setSnackBarType(isError: true, message: "Something went wrong");
    }
  }
}
