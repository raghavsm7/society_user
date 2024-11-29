import 'dart:convert';

import 'package:fl_sevengen_society_user_app/common/data/model/common_response_model.dart';
import 'package:fl_sevengen_society_user_app/constants/end_point_constants.dart';
import 'package:fl_sevengen_society_user_app/screens/post_listing/data/model/post_listing_response_model.dart';
import 'package:fl_sevengen_society_user_app/service/api.dart';

class PostListingProvider extends ApiServiceProvider {
  //api call send OTP
  Future<dynamic> callGetPostApi(
      {int? page, required int recordPerPage,int isAdminNotice=0}) async {
    var result = await getMethod(
      getPost,
      query: {
        "page": page.toString(),
        "record_per_page": recordPerPage.toString(),
        "admin_notice":isAdminNotice.toString()
      },
    );
    if (result is CommonResponseModel) {
      return result;
    } else {
      return PostResponseModelData.fromJson(result);
    }
  }

  Future<dynamic> callLikeOrDislikePostApi({int? postId}) async {
    var result = await postMethod(
      "posts/$postId/like",
      jsonEncode({}),
      forNullData: true,
    );
    if (result is CommonResponseModel) {
      return result;
    }
  }
}
