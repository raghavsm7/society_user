import 'package:fl_sevengen_society_user_app/common/data/model/common_response_model.dart';
import 'package:fl_sevengen_society_user_app/controller/base_controller.dart';
import 'package:fl_sevengen_society_user_app/screens/auth/data/model/auth_response_model.dart';
import 'package:fl_sevengen_society_user_app/screens/post_listing/data/provider/post_listing_provider.dart';
import 'package:fl_sevengen_society_user_app/utils/app_utils.dart';
import 'package:fl_sevengen_society_user_app/utils/network_utils.dart';
import 'package:get/get.dart';
import 'package:fl_sevengen_society_user_app/screens/post_listing/data/model/post_listing_response_model.dart';
class HomeController extends BaseController {
  AuthResponseModel? authResponseModel;

  // late BuildContext context;
  late PostListingProvider _provider;
  PostResponseModelData? adminPostListingResponseModel;
  bool noAdminPostFound = false;

  // Page
  int adminPostPage = 1;
  String latestNoticeToShow = "";

  @override
  void onInit() {
    super.onInit();
    _provider = Get.find<PostListingProvider>();
    callAdminPostListingAPI();
  }


  //method to call admin post listing API
  void callAdminPostListingAPI() {
    print("Admin post API");
    NetworkUtils.networkUtilsInstance
        .getConnectivityStatus(showSnackBar: true)
        .then((value) async {
      if (value) {
        updateLoading(value: true);

        var result = await _provider.callGetPostApi(
            page: adminPostPage, recordPerPage: 30,isAdminNotice: 1);

        if (result is CommonResponseModel) {
          // show error
          if (adminPostPage > 1) {
            adminPostPage = adminPostPage - 1;
          } else {
            adminPostListingResponseModel = null;
            if (result.statusCode == 404) {
              noAdminPostFound = true;
            } else {
              // some error
              AppUtils.appUtilsInstance.setSnackBarType(
                  isError: true,
                  message: result.message ?? "Something went wrong");
            }
          }
        } else if (result is PostResponseModelData) {
          noAdminPostFound = false;
          PostResponseModelData model = result;
          if (adminPostPage > 1) {
            adminPostListingResponseModel?.data?.posts
                ?.addAll(model.data!.posts!);
          } else {
            adminPostListingResponseModel = model;
            if(adminPostListingResponseModel!=null && adminPostListingResponseModel?.data!=null) {
              latestNoticeToShow=adminPostListingResponseModel!.data!.posts![0]!.content!;
            }
           // setDataInNotices(adminPostListingResponseModel);
          }
        }
        updateLoading();
      }
    });
  }


}
