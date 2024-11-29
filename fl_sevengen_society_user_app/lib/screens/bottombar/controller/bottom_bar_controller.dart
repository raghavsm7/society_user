import 'package:fl_sevengen_society_user_app/common/data/model/common_response_model.dart';
import 'package:fl_sevengen_society_user_app/common/data/model/push_notification_model.dart';
import 'package:fl_sevengen_society_user_app/screens/auth/data/model/auth_response_model.dart';
import 'package:fl_sevengen_society_user_app/screens/auth/data/provider/auth_provider.dart';
import 'package:fl_sevengen_society_user_app/screens/post_listing/data/provider/post_listing_provider.dart';
import 'package:fl_sevengen_society_user_app/utils/app_utils.dart';
import 'package:fl_sevengen_society_user_app/utils/notification_utils.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import '../../../controller/base_controller.dart';
import '../../post_listing/data/model/post_listing_response_model.dart';

class BottomBarController extends BaseController implements NotificationReceiveListener {
  int selectedIndex = 0;
  late AuthResponseModel authResponseModel;

  // late BuildContext context;
  late PostListingProvider _provider;
  PostResponseModelData? adminPostListingResponseModel;
  bool noAdminPostFound = false;

  // Page
  int adminPostPage = 1;

  @override
  void onInit() {
    super.onInit();
    authResponseModel = Get.arguments;
    NotificationUtils.notificationUtilsInstance.listener.add(this);
    callIsUserVerifiedApi();
   // callAdminPostListingAPI();
  }

  @override
  void dispose() {
    super.dispose();
    NotificationUtils.notificationUtilsInstance.listener.remove(this);

  }

  void changeBottomBarTab(int index) {
    selectedIndex = index;
    updateLoading();
  }





  //api calling to check whether user is verified of not
  Future<void> callIsUserVerifiedApi() async {
    AuthProvider authProvider = Get.find<AuthProvider>();
    AppUtils.appUtilsInstance.hideKeyboard();
    updateLoading(value: true);
    var apiResult = await authProvider.callIsUserVerifiedOrNot();

    if (apiResult is CommonResponseModel) {
      // success
      if (apiResult.statusCode == HttpStatus.ok) {
        updateLoading();
      } else {
        updateLoading();
        AppUtils.appUtilsInstance.setSnackBarType(
            isError: true,
            message: apiResult.message ?? "Something went wrong");
      }
    } else if (apiResult is AuthResponseModel) {
      // authResponseModel = AppUtils.appUtilsInstance.getAuthResponseModelData();
      authResponseModel.data?.user?.verified = apiResult.data?.user?.verified;
      AppUtils.appUtilsInstance
          .saveAuthResponseModelData(authResponseModel: authResponseModel);

      updateLoading();
    } else {
      updateLoading();
      AppUtils.appUtilsInstance
          .setSnackBarType(isError: true, message: "Something went wrong");
    }
  }

  @override
  onNotificationReceive(PushNotificationModel data) {
    print("Hii onNotofiation mein bula rahe h");
   callIsUserVerifiedApi();
  }


}
