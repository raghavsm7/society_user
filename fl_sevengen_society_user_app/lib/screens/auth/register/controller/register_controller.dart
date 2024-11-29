import 'package:fl_sevengen_society_user_app/common/data/model/common_response_model.dart';
import 'package:fl_sevengen_society_user_app/constants/dimens.dart';
import 'package:fl_sevengen_society_user_app/controller/base_controller.dart';
import 'package:fl_sevengen_society_user_app/localization/localization_const.dart';
import 'package:fl_sevengen_society_user_app/route/app_routes.dart';
import 'package:fl_sevengen_society_user_app/screens/auth/data/model/auth_response_model.dart';
import 'package:fl_sevengen_society_user_app/screens/auth/data/model/data_model.dart';
import 'package:fl_sevengen_society_user_app/screens/auth/data/provider/auth_provider.dart';
import 'package:fl_sevengen_society_user_app/screens/auth/register/model/enter_details_request_model.dart';
import 'package:fl_sevengen_society_user_app/theme/theme.dart';
import 'package:fl_sevengen_society_user_app/utils/app_utils.dart';
import 'package:fl_sevengen_society_user_app/utils/app_validator.dart';
import 'package:fl_sevengen_society_user_app/utils/network_utils.dart';
import 'package:fl_sevengen_society_user_app/widgets/common_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';

class RegisterController extends BaseController {
  late DataModel dataModel;
  bool obscureText = true;
  TextEditingController userNameController = TextEditingController();
  TextEditingController flatNumberController = TextEditingController();
  TextEditingController societyCodeController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  late RegisterDetailsRequestModel registerDetailsRequestModel;
  bool isPasswordVisible = true;
  bool isConfirmPasswordVisible = true;

  @override
  void onInit() {
    super.onInit();
    dataModel = Get.arguments;
  }


  checkIsPasswordVisible() {
    if (isPasswordVisible) {
      isPasswordVisible = false;
    } else {
      isPasswordVisible = true;
    }
    updateLoading(value: false);
  }

  checkIsConfirmPasswordVisible() {
    if (isConfirmPasswordVisible) {
      isConfirmPasswordVisible = false;
    } else {
      isConfirmPasswordVisible = true;
    }
    updateLoading(value: false);
  }

  //method to show and hide password
  showOrHidePasswordText(bool isTextObscure) {
    if (isTextObscure == true) {
      obscureText = false;
    } else {
      obscureText = true;
    }
  }

  void actionOnSubmitClick(
      RegisterController registerController, BuildContext context) {
    AppUtils.appUtilsInstance.hideKeyboard();
    registerDetailsRequestModel = RegisterDetailsRequestModel(
        name: userNameController.text.trim(),
        flatNumber: flatNumberController.text.trim(),
        societyCode: societyCodeController.text.trim(),
        password: passwordController.text.trim(),
        cnfPassword: confirmPasswordController.text.trim());

    String result = AppValidator.appValidatorInstance
        .validateRegisterPage(registerDetailsRequestModel, registerController);

    if (GetUtils.isNullOrBlank(result) == true) {
      print("The enter details page is valid");
      NetworkUtils.networkUtilsInstance.getConnectivityStatus().then((value) {
        if (value == true) {
          _callRegisterApi(context);
        }
      });
    } else {
      // show validation error
      AppUtils.appUtilsInstance.setSnackBarType(isError: true, message: result);
    }
  }

  //This method is used to call register API
  Future<void> _callRegisterApi(BuildContext context) async {
    AuthProvider authProvider = Get.find<AuthProvider>();
    AppUtils.appUtilsInstance.hideKeyboard();
    updateLoading(value: true);
    var apiResult = await authProvider.callRegisterApi(
        phoneNumber: dataModel.phoneNumber,
        societyCode: societyCodeController.text.trim(),
        username: userNameController.text.trim(),
        password: passwordController.text.trim(),
        flatNumber: flatNumberController.text.trim());

    if (apiResult is CommonResponseModel) {
      // success
      if (apiResult.statusCode == HttpStatus.ok) {
        updateLoading();

        // Get.offAllNamed(Routes.bottomBar);
      } else {
        updateLoading();
        AppUtils.appUtilsInstance.setSnackBarType(
            isError: true,
            message: apiResult.message ?? "Something went wrong");
      }
    } else if (apiResult is AuthResponseModel) {
      updateLoading();
      AppUtils.appUtilsInstance
          .saveAuthResponseModelData(authResponseModel: apiResult);
      _showApprovalSendToAdminDialog(context, apiResult);
    } else {
      updateLoading();
      AppUtils.appUtilsInstance
          .setSnackBarType(isError: true, message: "Something went wrong");
    }
  }

  //show alert dialog when user successfully register in the app and needs admin approval
  _showApprovalSendToAdminDialog(
      BuildContext context, AuthResponseModel authResponseModel) {
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
                horizontal: fixPadding * 1.0, vertical: fixPadding * 3.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  getTranslate(context, 'Admin Approval'),
                  style: semibold16Primary,
                ),
                heightSpace,
                heightSpace,
                heightSpace,
                Text(
                  getTranslate(context,
                      'Please wait until admin approves your request.'),
                  style: medium14Black,
                  textAlign: TextAlign.center,
                ),
                heightSpace,
                heightSpace,
                heightSpace,
                normalButton(
                    height: size_5,
                    title: "OK",
                    width: AppUtils.appUtilsInstance
                        .getPercentageSize(percentage: size_30, ofWidth: true),
                    elevation: size_0,
                    padding: size_8,
                    callBack: () {
                      Get.offAllNamed(Routes.bottomBar,
                          arguments: authResponseModel);
                    }),
              ],
            ),
          ),
        );
      },
    );
  }
}
