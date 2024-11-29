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

class EnterMobileNumberController extends BaseController {
  TextEditingController phoneNumberController = TextEditingController();
  late AuthProvider _authProvider;



  //call on the click of submit button
  void actionOnSubmitClick() {
    bool result = AppValidator.appValidatorInstance
        .checkValidPhoneNumber(phoneNumberController.text.trim());
    if (result == true) {
      NetworkUtils.networkUtilsInstance.getConnectivityStatus().then((value) {
        if (value == true) {
          _callSendOtpApi();
        }
      });

    } else {
      // show validation error
      AppUtils.appUtilsInstance.setSnackBarType(
          isError: true, message: "Please enter a valid 10 digit phone number");
    }
  }


  //method to call send otp API
  Future<void> _callSendOtpApi() async {
    _authProvider = Get.find<AuthProvider>();

    AppUtils.appUtilsInstance.hideKeyboard();

    updateLoading(value: true);

    var apiResult = await _authProvider.callSendOTPApi(
        phoneNumber: phoneNumberController.text.trim());

    if (apiResult is CommonResponseModel) {
      // some error
      if (apiResult.statusCode == HttpStatus.ok) {
        // navigate to verify otp screen
           Get.toNamed(Routes.verifyOTP,
            arguments: DataModel(
                phoneNumber: phoneNumberController.text.trim(),
                navigationEnums: OTPNavigationEnums.fromEnterMobile));
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
