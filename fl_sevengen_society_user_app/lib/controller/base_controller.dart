import 'package:fl_sevengen_society_user_app/utils/app_utils.dart';
import 'package:get/get.dart';


abstract class BaseController extends GetxController {
  bool loading = false;
  String message = "";
 // late AppLocalizationsData appLocal;

  // used to update loader
  updateLoading({bool value = false}) {
    loading = value;
    update();
  }

  @override
  void onInit() {
    if (Get.context != null) {
      //appLocal = AppLocalizations.of(Get.context!);
    }

    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    AppUtils.appUtilsInstance.hideKeyboard();
  }

}