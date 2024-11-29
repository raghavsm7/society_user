import 'package:fl_sevengen_society_user_app/common/data/model/common_response_model.dart';
import 'package:fl_sevengen_society_user_app/localization/localization_const.dart';
import 'package:fl_sevengen_society_user_app/route/app_routes.dart';
import 'package:fl_sevengen_society_user_app/screens/auth/data/model/auth_response_model.dart';
import 'package:fl_sevengen_society_user_app/screens/auth/data/provider/auth_provider.dart';
import 'package:fl_sevengen_society_user_app/theme/theme.dart';
import 'package:fl_sevengen_society_user_app/utils/app_utils.dart';
import 'package:fl_sevengen_society_user_app/utils/app_validator.dart';
import 'package:fl_sevengen_society_user_app/utils/network_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import '../../../../controller/base_controller.dart';

class LogInController extends BaseController {
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isPasswordVisible = true;



  checkIsPasswordVisible() {
    if (isPasswordVisible) {
      isPasswordVisible = false;
    } else {
      isPasswordVisible = true;
    }
    updateLoading(value: false);
  }

  void actionOnTheClickOfSubmitButton(
      LogInController logInController, BuildContext context) {
    String result = AppValidator.appValidatorInstance.validateLogInPage(
        phoneNumberController.text.trim(),
        passwordController.text.trim(),
        logInController);

    if (GetUtils.isNullOrBlank(result) == true) {
      if (phoneNumberController.text.isNotEmpty &&
          phoneNumberController.text.length == 10) {
        print("The enter details page is valid");
        NetworkUtils.networkUtilsInstance.getConnectivityStatus().then((value) {
          if (value == true) {
            _callLogInApi(context);
          }
        });
      } else {
        AppUtils.appUtilsInstance.setSnackBarType(
            isError: true, message: "Please enter a valid phone number");
      }
    } else {
      // show validation error
      AppUtils.appUtilsInstance.setSnackBarType(isError: true, message: result);
    }
  }

  Future<void> _callLogInApi(BuildContext context) async {
    AuthProvider authProvider = Get.find<AuthProvider>();
    AppUtils.appUtilsInstance.hideKeyboard();
    updateLoading(value: true);
    var apiResult = await authProvider.callLogInApi(
      phoneNumber: phoneNumberController.text.trim(),
      password: passwordController.text.trim(),
    );

    if (apiResult is CommonResponseModel) {
      // success
      if (apiResult.statusCode == HttpStatus.ok) {
        updateLoading();
        Get.offAllNamed(Routes.bottomBar);
        // updateLoading();
      }
      /*else if (_apiResult.statusCode == HttpStatus.forbidden) {
        updateLoading();
        //pleaseWaitDialog(context);
        AppUtils.appUtilsInstance
            .saveAuthResponseModelData(authResponseModel: _apiResult);
        Get.offAllNamed(Routes.bottomBar);
      }*/
      else {
        updateLoading();
        AppUtils.appUtilsInstance.setSnackBarType(
            isError: true,
            message: apiResult.message ?? "Something went wrong");
      }
    } else if (apiResult is AuthResponseModel) {
      updateLoading();
      AppUtils.appUtilsInstance
          .saveAuthResponseModelData(authResponseModel: apiResult);
      Get.offAllNamed(Routes.bottomBar, arguments: apiResult);
    } else {
      updateLoading();
      AppUtils.appUtilsInstance
          .setSnackBarType(isError: true, message: "Something went wrong");
    }
  }

  pleaseWaitDialog(BuildContext context) {
    return showDialog(
      barrierDismissible: true,
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
                  getTranslate(context,
                      'Please wait until admin approves your request.'),
                  style: semibold18Primary,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
