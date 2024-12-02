import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:fl_sevengen_society_user_app/enums/app_enums.dart';
import 'package:fl_sevengen_society_user_app/screens/auth/controller/auth_controller.dart';
import 'package:fl_sevengen_society_user_app/utils/app_utils.dart';
import 'package:fl_sevengen_society_user_app/utils/log_utils.dart';
import 'package:fl_sevengen_society_user_app/utils/storage_utils.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:http/http.dart' as http;
import '../common/data/model/common_response_model.dart';
import '../constants/end_point_constants.dart';

abstract class ApiServiceProvider extends GetConnect {
  late AuthController _authController;

  @override
  void onInit() {
    // super.onInit();
    _authController = Get.find<AuthController>();

    httpClient.baseUrl = _authController.getApiUrl();
    AppUtils.appUtilsInstance.getDeviceID();

    // baseUrl = 'https://api.covid19api.com'; // It define baseUrl to
    // Http and websockets if used with no [httpClient] instance

    // It's will attach 'apikey' property on header from all requests
    httpClient.addRequestModifier((Request request) {
      request.headers["Content-Type"] = "application/json";
      request.headers["Accept"] = "application/json";
     // request.headers["USERNAME"] = "BubbLesAppAPILevelaCCeSS";
     // request.headers["PASSWORD"] = "BubbLesAppAPILevelaCCeSSPass&&woRd";
      request.headers["Authorization"] = (GetUtils.isNullOrBlank(
                  _authController.authResponseModel?.data?.accessToken) ==
              false)
          ? "Bearer ${_authController.authResponseModel?.data?.accessToken?.toString()}"
          : "";
      LogUtils.printLog(
          tag: "Authorization",
          message:
              "Bearer ${_authController.authResponseModel?.data?.accessToken}");
       request.headers["Device-Token"] =
          "${StorageUtils.storageUtilsInstance.getFromPermanentStorage(key: StorageUtilsEnum.fcmToken.value)}";
      request.headers["deviceId"] = AppUtils.appUtilsInstance.deviceId;
      request.headers["Platform"] = (GetPlatform.isAndroid) ? "0" : "1";

      return request;
    });

    httpClient.addAuthenticator((Request request) async {
      return request;
    });

    //Authenticator will be called 3 times if HttpStatus is
    //HttpStatus.unauthorized
    httpClient.maxAuthRetries = 1;
    httpClient.timeout = const Duration(seconds: 40);
  }

  // get method
  Future<dynamic> getMethod(
    String url, {
    Map<String, String>? headers,
    String? contentType,
    Map<String, dynamic>? query,
  }) async {
    // String baseUrl = httpClient.baseUrl.toString();
    LogUtils.printLog(tag: " REQUEST $url", message: query.toString());
    try {
      var result = await get(url,
          contentType: contentType, headers: headers, query: query);
      LogUtils.printLog(
          tag: url,
          message:
              "${result.status.code} ${result.body}");
      if (result.status.isUnauthorized) {
        // handle non authentication case;
        //clear storage
        AppUtils.appUtilsInstance.handleUnauthorizedCase();
        return CommonResponseModel.fromJson(result.body);
      } else if (result.status.isOk) {
        return result.body;
      } else {
        return CommonResponseModel.fromJson(result.body);
      }
    } catch (e) {
      LogUtils.printLog(tag: url, message: e.toString());
      return CommonResponseModel(message: "Something went wrong!!");
    }
  }

  // post method
  Future<dynamic> postMethod(
    String url,
    dynamic body, {
    String? contentType,
    Map<String, String>? headers,
    Map<String, dynamic>? query,
    Progress? uploadProgress,
    bool forNullData = false,
  }) async {
   // String baseUrl = httpClient.baseUrl.toString() + url;
    LogUtils.printLog(tag: "REQUEST $baseUrl", message: body.toString());
    try {
      var result = await post(url, body,
          query: query,
          headers: headers,
          contentType: contentType,
          uploadProgress: uploadProgress);
      LogUtils.printLog(
          tag: url,
          message: "${result.status.code} ${result.body ?? ""}");

      if (result.status.isUnauthorized) {
        // handle non authentication case;
        //clear storage
        AppUtils.appUtilsInstance.handleUnauthorizedCase();
        return CommonResponseModel.fromJson(result.body);
      } else if (result.status.isOk) {
        if (forNullData == true) {
          return CommonResponseModel.fromJson(result.body);
        } else {
          return result.body;
        }
      } else {
        return CommonResponseModel(
            message: result.body[ApiStatusParams.message.value],
            statusCode: result.statusCode);
      }
    } catch (e) {
      LogUtils.printLog(tag: url, message: e.toString());
      return CommonResponseModel(message: "Something went wrong!!");
    }
  }

// put method
  Future<dynamic> putMethod(
    String url,
    dynamic body, {
    String? contentType,
    Map<String, String>? headers,
    Map<String, dynamic>? query,
    Progress? uploadProgress,
  }) async {
    try {
      var result = await put(url, body,
          query: query,
          headers: headers,
          contentType: contentType,
          uploadProgress: uploadProgress);
      LogUtils.printLog(
          tag: url,
          message:
              "${result.status.code} ${result.body}");
      if (result.status.isUnauthorized) {
        // handle non authentication case;
        //clear storage
        AppUtils.appUtilsInstance.handleUnauthorizedCase();
        return CommonResponseModel.fromJson(result.body);
      } else if (result.status.isOk) {
        return result.body;
      } else {
        return CommonResponseModel.fromJson(result.body);
      }
    } catch (e) {
      LogUtils.printLog(tag: url, message: e.toString());

      return CommonResponseModel(message: "Something went wrong!!");
    }
  }

// delete method
  Future<dynamic> deleteMethod(
    String url, {
    Map<String, String>? headers,
    String? contentType,
    Map<String, dynamic>? query,
  }) async {
    try {
      var result = await delete(
        url,
        query: query,
        headers: headers,
        contentType: contentType,
      );
      LogUtils.printLog(
          tag: url,
          message: result.body.toString() + result.statusCode.toString());
      if (result.status.isUnauthorized) {
        // handle non authentication case;
        //clear storage
        AppUtils.appUtilsInstance.handleUnauthorizedCase();
        return CommonResponseModel.fromJson(result.body);
      } else if (result.status.isOk) {
        return result.body;
      } else {
        return CommonResponseModel.fromJson(result.body);
      }
    } catch (e) {
      LogUtils.printLog(tag: url, message: e.toString());
      return CommonResponseModel(message: "Something went wrong!!");
    }
  }

// patch method
  Future<dynamic> patchMethod(
    String url,
    dynamic body, {
    String? contentType,
    Map<String, String>? headers,
    Map<String, dynamic>? query,
    Progress? uploadProgress,
  }) async {
    LogUtils.printLog(tag: " REQUEST $url", message: body.toString());
    try {
      var result = await patch(url, body,
          query: query,
          headers: headers,
          contentType: contentType,
          uploadProgress: uploadProgress);
      LogUtils.printLog(
          tag: url,
          message:
              "${result.status.code} ${result.body}");
      if (result.status.isUnauthorized) {
        // handle non authentication case;
        //clear storage
        AppUtils.appUtilsInstance.handleUnauthorizedCase();
        return CommonResponseModel.fromJson(result.body);
      } else if (result.status.isOk) {
        return result.body;
      } else {
        return CommonResponseModel.fromJson(result.body);
      }
    } catch (e) {
      LogUtils.printLog(tag: url, message: e.toString());
      return CommonResponseModel(message: "Something went wrong!!");
    }
  }

  Future<dynamic> callMultipartRequest({String? imagePath}) async {
    LogUtils.printLog(
        tag: "Authorization",
        message:
            "Bearer ${Get.find<AuthController>().authResponseModel?.data?.accessToken}");
    Map<String, String> requestHeaders = {
      'Content-type': 'multipart/form-data',
      'Accept': 'application/json',
      'Platform': (GetPlatform.isAndroid) ? "0" : "1",
      'fcmToken': "${StorageUtils.storageUtilsInstance.getFromPermanentStorage(key: StorageUtilsEnum.fcmToken.value)}",
      'deviceId': AppUtils.appUtilsInstance.deviceId,
      'Authorization':
          "Bearer ${Get.find<AuthController>().authResponseModel?.data?.accessToken}",
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse(httpClient.baseUrl! + uploadImage ));
    request.files.add(http.MultipartFile(
        'image',
        File(imagePath ?? "").readAsBytes().asStream(),
        File(imagePath ?? "").lengthSync(),
        filename: imagePath!.split("/").last));
    request.headers.addAll(requestHeaders);

    var res = await request.send();
    var response = await http.Response.fromStream(res);

    LogUtils.printLog(
        tag: /* uploadImage*/ "",
        message: "${res.statusCode} ${response.body}");
    if (res.statusCode == HttpStatus.unauthorized) {
      // handle non authentication case;
      //clear storage
      AppUtils.appUtilsInstance.handleUnauthorizedCase();
      return CommonResponseModel.fromJson(json.decode(response.body));
    } else {
      if (res.statusCode == HttpStatus.ok) {
        return json.decode(response.body);
      } else {
        // handle non authentication case;
        return CommonResponseModel.fromJson(json.decode(response.body));
      }
    }
  }
}
