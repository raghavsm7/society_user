import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fl_sevengen_society_user_app/constants/color.dart';
import 'package:fl_sevengen_society_user_app/constants/dimens.dart';
import 'package:fl_sevengen_society_user_app/utils/app_constants.dart';
import 'package:fl_sevengen_society_user_app/utils/app_utils.dart';
import 'package:fl_sevengen_society_user_app/utils/log_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImageUtils {
  static final ImageUtils _imageUtils = ImageUtils();
  static ImageUtils get imageUtilsInstance => _imageUtils;
  ImagePicker picker = ImagePicker();

  Widget showCacheNetworkImage({
    required String imageURL,
    String placeHolderImage = "",
    Icon? icon,
    double placeholderPadding = size_0,
    BoxShape shape = BoxShape.rectangle,
    double height = double.maxFinite,
    double width = double.maxFinite,
    BoxFit fit = BoxFit.cover,
    Color? placeholderColor,
    bool showProgressBarInPlaceHolder = false,
    bool showDefaultErrorWidget = false,
  }) {
    return CachedNetworkImage(
      height: height,
      width: width,
      imageUrl: imageURL,
      imageBuilder: (context, imageProvider) => Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          shape: shape,
          color: Colors.transparent,
          image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
        ),
      ),
      fit: fit,
      placeholder: (context, url) {
        return (showProgressBarInPlaceHolder)
            ? const Center(child: CircularProgressIndicator())
            : Center(
                child: Padding(
                  padding: EdgeInsets.all(placeholderPadding),
                  child: SizedBox(
                    height: height,
                    width: width,
                    child: (placeholderColor == null)
                        ? showSVGImage(
                            placeHolderImage,
                            height: height,
                            width: width,
                            fit: fit,
                          )
                        : showSVGIcons(
                            placeHolderImage,
                            height: height,
                            width: width,
                            fit: fit,
                            color: placeholderColor,
                          ),
                  ),
                ),
              );
      },
      errorWidget: (context, url, error) {
        LogUtils.printLog(
            tag: "CachedNetworkImage ERROR on $imageURL", message: "$error");
        return (showDefaultErrorWidget)
            ? const Icon(Icons.error)
            : (icon != null)
                ? Padding(
                    padding: EdgeInsets.all(placeholderPadding),
                    child: icon,
                  )
                : Padding(
                    padding: EdgeInsets.all(placeholderPadding),
                    child: (placeholderColor == null)
                        ? Center(
                            child: showSVGImage(
                              placeHolderImage,
                              height: height,
                              width: width,
                              fit: fit,
                            ),
                          )
                        : Center(
                            child: showSVGIcons(
                              placeHolderImage,
                              height: height,
                              width: width,
                              fit: fit,
                              color: placeholderColor,
                            ),
                          ),
                  );
      },
    );
  }

  Future<File> imgFromCamera() async {
    File image0 = File("");
    final XFile? xFile = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
    );
    if (xFile != null) {
      File image = File(xFile.path);
      image0 = await _cropImage(image);
    }
    return image0;
  }

  Future<File> imgFromGallery() async {
    File image0 = File("");
    final XFile? xFile = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );
    if (xFile != null) {
      File image = File(xFile.path);
      image0 = await _cropImage(image);
    }
    return image0;
  }

  Future<File> _cropImage(File image) async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: image.path,
      aspectRatioPresets: GetPlatform.isAndroid
          ? [
              CropAspectRatioPreset.square,
              CropAspectRatioPreset.ratio3x2,
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.ratio4x3,
              CropAspectRatioPreset.ratio16x9
            ]
          : [
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.square,
              CropAspectRatioPreset.ratio3x2,
              CropAspectRatioPreset.ratio4x3,
              CropAspectRatioPreset.ratio5x3,
              CropAspectRatioPreset.ratio5x4,
              CropAspectRatioPreset.ratio7x5,
              CropAspectRatioPreset.ratio16x9
            ],
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: appName,
          toolbarColor: Colors.deepOrange,
          toolbarWidgetColor: colorWhite,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false,
        ),
        IOSUiSettings(title: appName),
      ],
    );
    return croppedFile != null ? File(croppedFile.path) : image;
  }

  Widget showSVGIcons(
    String image, {
    double padding = size_0,
    double height = size_5,
    double width = size_5,
    double progressIndicatorSize = size_5,
    Color? color = colorIconBlack,
    Color progressIndicatorColor = colorPrimary,
    bool ofWidth = false,
    bool staticDim = false,
    BoxFit fit = BoxFit.contain,
    bool showProgressIndicator = false,
  }) {
    return Padding(
      padding: EdgeInsets.all(
        AppUtils.appUtilsInstance
            .getPercentageSize(ofWidth: false, percentage: padding),
      ),
      child: SvgPicture.asset(
        image,
        fit: fit,
        height: (staticDim)
            ? height
            : AppUtils.appUtilsInstance
                .getPercentageSize(ofWidth: ofWidth, percentage: height),
        width: (staticDim)
            ? width
            : AppUtils.appUtilsInstance.getPercentageSize(
                ofWidth: ofWidth, percentage: (ofWidth) ? width : height),
        colorFilter:
            color != null ? ColorFilter.mode(color, BlendMode.srcIn) : null,
        placeholderBuilder: (BuildContext context) => (showProgressIndicator)
            ? SizedBox(
                height: AppUtils.appUtilsInstance.getPercentageSize(
                    ofWidth: ofWidth, percentage: progressIndicatorSize),
                width: AppUtils.appUtilsInstance.getPercentageSize(
                    ofWidth: ofWidth, percentage: progressIndicatorSize),
                child: CircularProgressIndicator(
                  color: progressIndicatorColor,
                  strokeWidth: progressIndicatorSize / size_2_5,
                ))
            : const SizedBox(),
      ),
    );
  }

  Widget showSVGImage(
    String image, {
    double padding = size_0,
    double height = size_100,
    double width = size_100,
    double progressIndicatorSize = size_11,
    Color progressIndicatorColor = colorPrimary,
    bool ofWidth = false,
    BoxFit fit = BoxFit.contain,
  }) {
    return Padding(
      padding: EdgeInsets.all(
        AppUtils.appUtilsInstance
            .getPercentageSize(ofWidth: false, percentage: padding),
      ),
      child: SvgPicture.asset(
        image,
        fit: fit,
        height:
            AppUtils.appUtilsInstance.getPercentageSize(percentage: height),
        width: AppUtils.appUtilsInstance
            .getPercentageSize(percentage: (ofWidth) ? width : height),
        placeholderBuilder: (BuildContext context) => Center(
          child: SizedBox(
            height: AppUtils.appUtilsInstance
                .getPercentageSize(ofWidth: ofWidth, percentage: progressIndicatorSize),
            width: AppUtils.appUtilsInstance
                .getPercentageSize(ofWidth: ofWidth, percentage: progressIndicatorSize),
            child: CircularProgressIndicator(
              color: progressIndicatorColor,
              strokeWidth: progressIndicatorSize / size_2_5,
            ),
          ),
        ),
      ),
    );
  }
}