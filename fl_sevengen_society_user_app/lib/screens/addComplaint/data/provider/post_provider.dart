import 'package:fl_sevengen_society_user_app/common/data/model/common_response_model.dart';
import 'package:fl_sevengen_society_user_app/constants/end_point_constants.dart';
import 'package:fl_sevengen_society_user_app/screens/addComplaint/data/model/post_request_model.dart';
import 'package:fl_sevengen_society_user_app/screens/addComplaint/data/model/post_response_model.dart';
import 'package:fl_sevengen_society_user_app/screens/addComplaint/data/model/upload_image_response_model.dart';
import 'package:fl_sevengen_society_user_app/service/api.dart';

class PostProvider extends ApiServiceProvider {
  // upload image
  Future<dynamic> callUploadImageApi(String? imagePath) async {
    var response = await callMultipartRequest(imagePath: imagePath);
    if (response is CommonResponseModel) {
      return response;
    } else {
      return UploadImageResponseModel.fromJson(response);
    }
  }

  //call submit post api
  Future<dynamic> callSubmitPostApi(
      {PostRequestModel? postRequestModel}) async {
    var result = await postMethod(
      posts,
      postRequestModel?.toJson(),
      forNullData: false,
    );
    if (result is CommonResponseModel) {
      return result;
    } else {
      return PostResponseModelDataDataPostsUserRoles.fromJson(result);
    }
    }
}
