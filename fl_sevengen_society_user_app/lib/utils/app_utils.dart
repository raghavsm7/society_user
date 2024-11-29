import 'package:device_info_plus/device_info_plus.dart';
import 'package:fl_sevengen_society_user_app/constants/color.dart';
import 'package:fl_sevengen_society_user_app/constants/text_style_constant.dart';
import 'package:fl_sevengen_society_user_app/enums/app_enums.dart';
import 'package:fl_sevengen_society_user_app/route/app_routes.dart';
import 'package:fl_sevengen_society_user_app/screens/auth/controller/auth_controller.dart';
import 'package:fl_sevengen_society_user_app/screens/auth/data/model/auth_response_model.dart';
import 'package:fl_sevengen_society_user_app/theme/theme.dart';
import 'package:fl_sevengen_society_user_app/utils/log_utils.dart';
import 'package:fl_sevengen_society_user_app/utils/storage_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../constants/dimens.dart';


class AppUtils {
  static final AppUtils _appUtils = AppUtils();

  static AppUtils get appUtilsInstance => _appUtils;


  // hide keyboard
  hideKeyboard() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
  }

  // get percentage size
  double getPercentageSize(
      {double? percentage = size_0, bool ofWidth = false}) {
    if (ofWidth) {
      return (Get.width * percentage!) / 100;
    } else {
      return (Get.height * percentage!) / 100;
    }
  }

  //common padding
  EdgeInsetsGeometry commonPadding({double percentage = size_2}) {
    return EdgeInsets.all(
      AppUtils.appUtilsInstance
          .getPercentageSize(percentage: percentage, ofWidth: false),
    );
  }

  //common padding
  EdgeInsetsGeometry commonSymmetricPadding({bool forWidth = true}) {
    return EdgeInsets.symmetric(
        horizontal: AppUtils.appUtilsInstance.getPercentageSize(
          percentage: forWidth ? size_2 : size_0,
        ),
        vertical: AppUtils.appUtilsInstance.getPercentageSize(
          percentage: forWidth ? size_0 : size_2,
        ));
  }

  // snack bar type
  setSnackBarType({
    bool isError = false,
    required String message,
  /*  required AppLocalizationsData appLocalizationsData,*/
  }) {
    if (isError == true) {
      showSnackBar(/*appLocalizationsData.common.text.error*/"Error", message,
          backgroundColor: primaryColor, colorText: colorWhite);
    } else {
      showSnackBar(/*appLocalizationsData.common.text.success*/"Success", message);
    }
  }

  String getStarPhoneNumber({required String phoneNumber}) {
    String result = "";
    result = phoneNumber.replaceRange(
        0, (phoneNumber.length - 2), 'X' * (phoneNumber.length - 5));
    return result;
  }



  // show SnackBar
  showSnackBar(
    String title,
    String message, {
    Color? colorText = colorWhite,

    /// with instantInit = false you can put snackbar on initState
    bool instantInit = true,
    SnackPosition? snackPosition = SnackPosition.BOTTOM,
    Widget? titleText,
    Widget? messageText,
    Widget? icon,
    bool? shouldIconPulse,
    double? maxWidth,
    EdgeInsets? margin = EdgeInsets.zero,
    EdgeInsets? padding,
    double? borderRadius = size_0,
    Color? borderColor,
    double? borderWidth,
    Color? backgroundColor = primaryColor,
    Color? leftBarIndicatorColor,
    List<BoxShadow>? boxShadows,
    Gradient? backgroundGradient,
    TextButton? mainButton,
    OnTap? onTap,
    bool? isDismissible,
    bool? showProgressIndicator,
    DismissDirection? dismissDirection,
    AnimationController? progressIndicatorController,
    Color? progressIndicatorBackgroundColor,
    Animation<Color>? progressIndicatorValueColor,
    SnackStyle? snackStyle,
    Curve? forwardAnimationCurve,
    Curve? reverseAnimationCurve,
    Duration? animationDuration,
    double? barBlur,
    double? overlayBlur,
    SnackbarStatusCallback? snackbarStatus,
    Color? overlayColor,
    Form? userInputForm,
  }) {
    if (Get.isSnackbarOpen == false) {
      Get.snackbar(title, message,
          margin: margin,
          padding: padding,
          duration: const Duration(milliseconds: 2500),
          snackPosition: snackPosition,
          borderRadius: borderRadius,
          onTap: onTap,
          animationDuration: animationDuration,
          backgroundColor: backgroundColor,
          backgroundGradient: backgroundGradient,
          barBlur: barBlur,
          borderColor: borderColor,
          borderWidth: borderWidth,
          boxShadows: boxShadows,
          colorText: colorText,
          dismissDirection: dismissDirection,
          forwardAnimationCurve: forwardAnimationCurve,
          icon: icon,
          instantInit: instantInit,
          isDismissible: isDismissible,
          leftBarIndicatorColor: leftBarIndicatorColor,
          mainButton: mainButton,
          maxWidth: maxWidth,
          messageText: messageText,
          overlayBlur: overlayBlur,
          overlayColor: overlayColor,
          progressIndicatorBackgroundColor: progressIndicatorBackgroundColor,
          progressIndicatorController: progressIndicatorController,
          progressIndicatorValueColor: progressIndicatorValueColor,
          reverseAnimationCurve: reverseAnimationCurve,
          shouldIconPulse: shouldIconPulse,
          showProgressIndicator: showProgressIndicator,
          snackbarStatus: snackbarStatus,
          snackStyle: snackStyle,
          titleText: titleText,
          userInputForm: userInputForm);
    }
  }

  // show general dialog
  showGeneralDialog({
    required RoutePageBuilder pageBuilder,
    bool barrierDismissible = false,
    String? barrierLabel,
    Color barrierColor = const Color(0x80000000),
    Duration transitionDuration = const Duration(milliseconds: 200),
    RouteTransitionsBuilder? transitionBuilder,
    GlobalKey<NavigatorState>? navigatorKey,
    RouteSettings? routeSettings,
  }) {
    Get.generalDialog(
        pageBuilder: pageBuilder,
        barrierColor: barrierColor,
        barrierDismissible: barrierDismissible,
        barrierLabel: barrierLabel,
        routeSettings: routeSettings,
        transitionBuilder: transitionBuilder,
        transitionDuration: transitionDuration);
  }

  // show dilaog
  showDialog(
    Widget widget, {
    bool barrierDismissible = true,
    Color? barrierColor,
    bool useSafeArea = true,
    GlobalKey<NavigatorState>? navigatorKey,
    Object? arguments,
    Duration? transitionDuration,
    Curve? transitionCurve,
    String? name,
    RouteSettings? routeSettings,
  }) {
    Get.dialog(widget,
        transitionDuration: transitionDuration,
        routeSettings: routeSettings,
        barrierDismissible: barrierDismissible,
        barrierColor: barrierColor,
        arguments: arguments,
        name: name,
        transitionCurve: transitionCurve,
        useSafeArea: useSafeArea);
  }

  // show default dialog
  showDefaultDialog({
    String title = "Alert",
    EdgeInsetsGeometry? titlePadding,
    TextStyle? titleStyle,
    Widget? content,
    EdgeInsetsGeometry? contentPadding,
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
    VoidCallback? onCustom,
    Color? cancelTextColor,
    Color? confirmTextColor,
    String? textConfirm,
    String? textCancel,
    String? textCustom,
    Widget? confirm,
    Widget? cancel,
    Widget? custom,
    Color? backgroundColor,
    bool barrierDismissible = true,
    Color? buttonColor,
    String middleText = "",
    TextStyle? middleTextStyle,
    double radius = 20.0,
    //   ThemeData themeData,
    List<Widget>? actions,

    // onWillPop Scope
    WillPopCallback? onWillPop,

    // the navigator used to push the dialog
    GlobalKey<NavigatorState>? navigatorKey,
  }) {
    Get.defaultDialog(
      barrierDismissible: barrierDismissible,
      backgroundColor: backgroundColor,
      middleText: middleText,
      title: title,
      titlePadding: titlePadding,
      actions: actions,
      buttonColor: buttonColor,
      cancel: cancel,
      cancelTextColor: cancelTextColor,
      confirm: confirm,
      confirmTextColor: cancelTextColor,
      content: content,
      custom: custom,
      middleTextStyle: middleTextStyle,
      onCancel: onCancel,
      onConfirm: onConfirm,
      onCustom: onCustom,
      onWillPop: onWillPop,
      radius: radius,
      textCancel: textCancel,
      textConfirm: textConfirm,
      textCustom: textCustom,
      titleStyle: titleStyle,
    );
  }

  // default app bar
  AppBar getAppBar({
    String appBarTitle = "", // app bar title
    TextStyle? appBarTitleStyle, // app bar title text style
    Function? defaultLeadIconPressed, // if default icon set then customize tap
    Widget? leadingWidget, // customize leading widget
    Icon? defaultLeadingIcon, // change leading icon from back pressed to other
    Color?
        defaultLeadingIconColor, // change default leading icon color from white to other
    double elevation = elevation_02,
    Color? backGroundColor, // app bar background color
    bool? centerTitle = true,
    List<Widget>? actionWidgets,
    bool? popScreenOnTapOfLeadingIcon = true, // send it false if you want tap
    Widget? appBarTitleWidget,
  }) {
    return AppBar(
      backgroundColor: backGroundColor ?? colorWhite,
      elevation: elevation,
      shadowColor: colorShadow.withBlue(4),
      centerTitle: centerTitle,
      title: appBarTitleWidget ??
          textWidget(
            appBarTitle,
            style: appBarTitleStyle ??
                textBlack(size: size_18, textStyleEnum: TextStyleEnum.bold),
          ),
      leading: leadingWidget ??
          IconButton(
            onPressed: () {
              if (popScreenOnTapOfLeadingIcon == true) {
                Get.back();
              }
              if (defaultLeadIconPressed != null) defaultLeadIconPressed();
            },
            icon: defaultLeadingIcon ??
                Icon(
                  Icons.arrow_back_rounded,
                  size: AppUtils.appUtilsInstance
                      .getPercentageSize(percentage: size_3_5),
                  color: defaultLeadingIconColor ?? colorPrimary,
                ),
          ),
      actions: actionWidgets,
    );
  }


  //////-------------Uncomment this code while working on auth module------/////
  //save default values to auth controller
 /* saveDefaultValuesToAuthController() {
    AuthController _authController = Get.find<AuthController>();
    if (_authController != null) {
      _authController.authResponseModel = AuthResponseModel();
    }
  }
 //////-------------Uncomment this code while working on auth module------/////




  //save authresponse model in pref as well as controller too
  saveAuthResponseModelData({required AuthResponseModel authResponseModel}) {
    LogUtils.printLog(
        tag: "SAVE_USER_DATA", message: "${authResponseModel.data?.toJson()}");
    StorageUtils.storageUtilsInstance.saveToStorage(
        key: StorageUtilsEnum.userData.value,
        value: authResponseModelToJson(authResponseModel));
    updateAuthModelInController(authResponseModel: authResponseModel);
  }*/

/*
  //save service selection data
  saveServiceSelectionData(
      {required ServiceWithQueRequestModel serviceWithQueRequestModel}) {
    LogUtils.printLog(
        tag: "SAVE_SERVICE_DATA",
        message: "${serviceWithQueRequestModel.toJson()}");
    StorageUtils.storageUtilsInstance.saveToStorage(
        key: StorageUtilsEnum.serviceData.value,
        value: serviceResponseModelToJson(serviceWithQueRequestModel));
    //updateAuthModelInController(authResponseModel: authResponseModel);
  }

  //get service selection data
  ServiceWithQueRequestModel getServiceSelectionData() {
    String? _userData = StorageUtils.storageUtilsInstance
        .getFromStorage(key: StorageUtilsEnum.serviceData.value);
    ServiceWithQueRequestModel serviceWithQueRequestModel =
        ServiceWithQueRequestModel.fromJson(
            StorageUtils.storageUtilsInstance.decodeData(data: _userData));
    return serviceWithQueRequestModel;
  }
*/

/*  //save service selection data
  saveVendorUploadedDocData(
      {required UploadDocumentModel uploadDocumentModel}) {
    LogUtils.printLog(
        tag: "SAVE_VENDOR_DOC_DATA",
        message: "${uploadDocumentModel.toJson()}");
    StorageUtils.storageUtilsInstance.saveToStorage(
        key: StorageUtilsEnum.docData.value,
        value: uploadDocRequestToJson(uploadDocumentModel));
    //updateAuthModelInController(authResponseModel: authResponseModel);
  }

  //get service selection data
  UploadDocumentModel getVendorUploadedDocData() {
    String? _userData = StorageUtils.storageUtilsInstance
        .getFromStorage(key: StorageUtilsEnum.docData.value);
    UploadDocumentModel uploadDocumentModel =
    UploadDocumentModel.fromJson(
        StorageUtils.storageUtilsInstance.decodeData(data: _userData));
    return uploadDocumentModel;
  }*/

  //save authresponse model in pref as well as controller too
  saveAuthResponseModelData({required AuthResponseModel authResponseModel}) {
    LogUtils.printLog(
        tag: "SAVE_USER_DATA", message: "${authResponseModel.data?.toJson()}");
    StorageUtils.storageUtilsInstance.saveToStorage(
        key: StorageUtilsEnum.userData.value,
        value: authResponseModelToJson(authResponseModel));
    updateAuthModelInController(authResponseModel: authResponseModel);
  }

  //update auth response model from controller
  updateAuthModelInController({required AuthResponseModel authResponseModel}) {
    AuthController authController = Get.find<AuthController>();
    authController.authResponseModel = authResponseModel;
    }

  //get auth response model from controller
  AuthResponseModel? getAuthResponseModelFromController() {
    AuthController authController = Get.find<AuthController>();
    return authController.authResponseModel;
      return null;
  }

  //get auth response model data
  AuthResponseModel getAuthResponseModelData() {
    String? userData = StorageUtils.storageUtilsInstance
        .getFromStorage(key: StorageUtilsEnum.userData.value);

    AuthResponseModel authResponseModel = AuthResponseModel.fromJson(
        StorageUtils.storageUtilsInstance.decodeData(data: userData));

    return authResponseModel;
  }

  // handle non authentication case;
  handleUnauthorizedCase() {
    //clear storage
    StorageUtils.storageUtilsInstance.clearStorage();
    saveDefaultValuesToAuthController();
    Get.offAllNamed(Routes.splash);
  }

//save default values to auth controller
  saveDefaultValuesToAuthController() {
    AuthController authController = Get.find<AuthController>();
    authController.authResponseModel = AuthResponseModel();
    }




  String deviceId = "";

  //for getting device id
  Future<void> getDeviceID() async {
  var deviceInfo = DeviceInfoPlugin();
  if (GetPlatform.isIOS) {
    var iosDeviceInfo = await deviceInfo.iosInfo;
    deviceId = iosDeviceInfo.identifierForVendor ?? ''; // unique ID on iOS
  } else if (GetPlatform.isAndroid) {
    var androidDeviceInfo = await deviceInfo.androidInfo;
    deviceId = androidDeviceInfo.id ?? ''; // Changed from androidId to id
  }
}

  // to show text
  Widget textWidget(
      String title, {
        TextStyle? style,
        TextAlign textAlign = TextAlign.left,
      }) {
    return Text(
      title,
      style: style,
      textAlign: textAlign,
    );
  }
}
