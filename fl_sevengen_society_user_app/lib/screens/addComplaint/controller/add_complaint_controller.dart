import 'dart:io';
import 'package:fl_sevengen_society_user_app/common/data/model/common_response_model.dart';
import 'package:fl_sevengen_society_user_app/controller/base_controller.dart';
import 'package:fl_sevengen_society_user_app/enums/app_enums.dart';
import 'package:fl_sevengen_society_user_app/screens/addComplaint/data/model/post_request_model.dart';
import 'package:fl_sevengen_society_user_app/screens/addComplaint/data/model/post_response_model.dart';
import 'package:fl_sevengen_society_user_app/screens/addComplaint/data/model/upload_image_response_model.dart';
import 'package:fl_sevengen_society_user_app/screens/addComplaint/data/provider/post_provider.dart';
import 'package:fl_sevengen_society_user_app/utils/app_utils.dart';
import 'package:fl_sevengen_society_user_app/utils/app_validator.dart';
import 'package:fl_sevengen_society_user_app/utils/image_utils.dart';
import 'package:fl_sevengen_society_user_app/utils/log_utils.dart';
import 'package:fl_sevengen_society_user_app/utils/network_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/get_utils/get_utils.dart';

class AddComplaintController extends BaseController {
  late PostProvider _postProvider;
  late UploadImageResponseModel uploadImageResponseModel =
  UploadImageResponseModel();
  TextEditingController postEditingController = TextEditingController();
  TextEditingController titleEditingController = TextEditingController();
  bool noAdminPostFound = false;



  // to select or take image
  Future<void> onImageOptionSelect(
      ImageSelectionEnum imageSelectionEnum) async {
    LogUtils.printLog(message: "$imageSelectionEnum");
    File imageFile;
    switch (imageSelectionEnum) {
      case ImageSelectionEnum.camera:
        imageFile = await ImageUtils.imageUtilsInstance.imgFromCamera();
        if (GetUtils.isNullOrBlank(imageFile.path) == false) {
          getUserImageLinkFromServer(imageFile.path);
        }
        break;
      case ImageSelectionEnum.gallery:
        imageFile = await ImageUtils.imageUtilsInstance.imgFromGallery();
        if (GetUtils.isNullOrBlank(imageFile.path) == false) {
          getUserImageLinkFromServer(imageFile.path);
        }
        break;
      case ImageSelectionEnum.remove:
      //getUserImageLinkFromServer("");
      /*   if (GetUtils.isNullOrBlank(authResponseModel.data?.profilePicture) == false) {
          updateUserImage("");
        }*/
        break;
    }
  }

  void getUserImageLinkFromServer(String image) {
    _postProvider = Get.find<PostProvider>();

// upload Image
    NetworkUtils.networkUtilsInstance
        .getConnectivityStatus()
        .then((value) async {
      if (value == true) {
        //show loader
        updateLoading(value: true);
        // calling upload image API
        var uploadProfileImageApiResult =
        await _postProvider.callUploadImageApi(
          image,
        );

        if (uploadProfileImageApiResult is CommonResponseModel) {
          // show error
          updateLoading();
          AppUtils.appUtilsInstance.setSnackBarType(
            isError: true,
            message: uploadProfileImageApiResult.message.toString(),
          );
        } else if (uploadProfileImageApiResult is UploadImageResponseModel) {
          print('In on upload image success');
          updateLoading();
          uploadImageResponseModel = uploadProfileImageApiResult;
          // on success
          //updateUserImage(_uploadProfileImageApiResult.data?.imagePath);
        }
      }
    });
  }

  void submitPost(BuildContext context) {
    String result = AppValidator.appValidatorInstance.checkValidPost(
        postEditingController.text.trim(), titleEditingController.text.trim());

    if (GetUtils.isNullOrBlank(result) == true) {
      print("The enter details page is valid");
      NetworkUtils.networkUtilsInstance.getConnectivityStatus().then((value) {
        if (value == true) {
          _callSubmitPostApi(context);
        }
      });
    } else {
      // show validation error
      AppUtils.appUtilsInstance.setSnackBarType(isError: true, message: result);
    }
  }

  Future<void> _callSubmitPostApi(BuildContext context) async {
    _postProvider = Get.find<PostProvider>();
    AppUtils.appUtilsInstance.hideKeyboard();
    updateLoading(value: true);
    var apiResult = await _postProvider.callSubmitPostApi(
        postRequestModel: PostRequestModel(
            title: "N/A",
            content: postEditingController.text.trim(),
            adminNotice: false,
            media: [uploadImageResponseModel.data?.imagePath]));

    if (apiResult is CommonResponseModel) {
      // success
      if (apiResult.statusCode == HttpStatus.ok) {
        updateLoading();
        print("Hii");

        // Get.offAllNamed(Routes.bottomBar);
      } else {
        updateLoading();
        AppUtils.appUtilsInstance.setSnackBarType(
            isError: true,
            message: apiResult.message ?? "Something went wrong");
      }
    } else if (apiResult is PostResponseModelDataDataPostsUserRoles) {
      print("Hii in post created sucessfully");
      postEditingController.clear();
      updateLoading();
      Get.back();
      /* titleEditingController.clear();
      postEditingController.clear();
      AppUtils.appUtilsInstance.setSnackBarType(
          isError: false,
          message: _apiResult.message ?? "Something went wrong");*/
    } else {
      updateLoading();
      AppUtils.appUtilsInstance
          .setSnackBarType(isError: true, message: "Something went wrong");
    }
  }

}
