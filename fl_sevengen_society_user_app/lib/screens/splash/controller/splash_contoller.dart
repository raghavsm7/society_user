import 'dart:async';
import 'package:fl_sevengen_society_user_app/controller/base_controller.dart';
import 'package:fl_sevengen_society_user_app/route/app_routes.dart';
import 'package:fl_sevengen_society_user_app/screens/auth/data/model/auth_response_model.dart';
import 'package:fl_sevengen_society_user_app/utils/app_utils.dart';
import 'package:fl_sevengen_society_user_app/utils/log_utils.dart';
import 'package:fl_sevengen_society_user_app/utils/storage_utils.dart';
import 'package:get/get.dart';


class SplashController extends BaseController {



  // Page
  int adminPostPage = 1;
  @override
  void onInit() {
    super.onInit();
    Timer(const Duration(seconds: 3), () {
      navigationFromSplashScreenTo();
    });
  }


  void navigationFromSplashScreenTo() {
// get user data
    String? userData =
    StorageUtils.storageUtilsInstance.getFromStorage(key: 'user_data');
    // check for data
    if (GetUtils.isNullOrBlank(userData) == false) {
      LogUtils.printLog(tag: "USER_DATA", message: "$userData");
      navigationWithAuthData();
    } else {
      Get.offAllNamed(Routes.login);
    }
  }

  void navigationWithAuthData() {
// get data from cache
    AuthResponseModel authResponseModel =
    AppUtils.appUtilsInstance.getAuthResponseModelData();
    // update data in auth controller
    AppUtils.appUtilsInstance
        .updateAuthModelInController(authResponseModel: authResponseModel);
    if (authResponseModel.data != null) {
      Get.offAllNamed(Routes.bottomBar, arguments: authResponseModel);
    } else {
      Get.offAllNamed(Routes.login);
    }
  }


}
