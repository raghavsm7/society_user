import 'dart:ui';
import 'package:fl_sevengen_society_user_app/constants/text_style_constant.dart';
import 'package:fl_sevengen_society_user_app/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/color.dart';
import '../constants/dimens.dart';
import '../utils/app_utils.dart';

// for text filed
Widget textFieldForm({
  required TextEditingController controller,
  TextInputType keyboardType = TextInputType.text,
  String? hint,
  FormFieldValidator<String>? validator,
  bool enabled = true,
  bool obscureText = false,
  bool textCapitalisation = false,
  int? maxLength,
  Color fillColor = Colors.white,
  double topPadding = size_0,
  double leftPadding = size_0,
  FocusNode? focusNode,
  // FocusNode? destinationFocusNode,
  TextInputAction? textInputAction,
  int maxLines = 1,
}) {
  return TextFormField(
    style: textBlack(),
    validator: validator,
    controller: controller,
    enabled: enabled,
    textInputAction: textInputAction,
    focusNode: focusNode,
    obscureText: obscureText,
    maxLength: maxLength,
    maxLines: maxLines,
    textCapitalization: (textCapitalisation)
        ? TextCapitalization.sentences
        : TextCapitalization.none,
    onFieldSubmitted: (value) {
      focusNode?.unfocus();
    },
    keyboardType: keyboardType,
    textAlignVertical: TextAlignVertical.center,
    cursorColor: colorPrimary,
    decoration: InputDecoration(
      counterText: "",
      fillColor: fillColor,
      filled: true,
      contentPadding:
          EdgeInsets.only(right: size_20, top: topPadding, left: leftPadding),
      alignLabelWithHint: true,
      hintText: hint,
      hintStyle: textGrey(),
      border: const OutlineInputBorder(borderSide: BorderSide.none),
    ),
  );
}

// used to create a normal button
Widget normalButton({
  required String title,
  required Function callBack,
  double? height,
  double? width,
  double cornerRadius = size_16,
  double elevation = elevation_05,
  double textSize = size_18,
  Color buttonColor = primaryColor,
  Color textColor = colorWhite,
  Color buttonBorderColor = Colors.transparent,
  bool wrap = false,
  double? padding,
}) {
  return RawMaterialButton(
    autofocus: false,
    constraints: BoxConstraints(
      minHeight: wrap ? 0 : height ?? size_6,
      minWidth: wrap ? 0 : width ?? double.maxFinite,
    ),
    onPressed: () {
      callBack();
    },
    fillColor: buttonColor,
    elevation: elevation,
    shape: RoundedRectangleBorder(
      side: BorderSide(color: buttonBorderColor, width: size_1),
      borderRadius: BorderRadius.circular(
        AppUtils.appUtilsInstance.getPercentageSize(
          percentage: cornerRadius,
        ),
      ),
    ),
    child: Padding(
      padding: EdgeInsets.all(padding ??
          AppUtils.appUtilsInstance.getPercentageSize(
            percentage: size_2_5,
          )),
      child: textWidget(title,
          style: textCustom(
            color: textColor,
            size: textSize,
            textStyleEnum: TextStyleEnum.semiBold,
          )),
    ),
  );
}

// for spacing
Widget spacing({
  double? size = size_2,
  bool isForWidth = false,
}) {
  return SizedBox(
    height: (isForWidth == false)
        ? AppUtils.appUtilsInstance
            .getPercentageSize(ofWidth: false, percentage: size)
        : size_0,
    width: (isForWidth == true)
        ? AppUtils.appUtilsInstance
            .getPercentageSize(ofWidth: true, percentage: size)
        : size_0,
  );
}

Widget spacingHeight({double? heightPercentage}) {
  return SizedBox(
    height: AppUtils.appUtilsInstance
        .getPercentageSize(ofWidth: false, percentage: heightPercentage),
  );
}

// Data not found
Widget dataNotFound(
    BuildContext context,
    /*AppLocalizationsData appLocal*/
    String message,
    double radius) {
  return Container(
    color: colorBackground,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: colorLightBlack, width: size_0_5),
            borderRadius: BorderRadius.circular(radius),
            color: colorLightBlack,
          ),
          child: Padding(
            padding: AppUtils.appUtilsInstance.commonPadding(),
            child: Column(
              children: [
                spacingHeight(heightPercentage: size_2),
                Icon(
                  Icons.error_outline_rounded,
                  size: AppUtils.appUtilsInstance
                      .getPercentageSize(percentage: size_10),
                  color: colorWhite,
                ),
                spacingHeight(heightPercentage: size_3),
                Text(
                  message,
                  style: textWhite(size: size_20),
                  textAlign: TextAlign.center,
                ),
                spacingHeight(heightPercentage: size_3),
              ],
            ),
          ),
        ),
      ],
    ),
  );
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

// container with gradient background
Widget getContainerWithGradient(
    {required Widget child,
    double? height,
    double? width,
    bool bottomLeftRound = false,
    bool topLeftRound = false,
    bool topRightRound = false,
    bool bottomRightRound = false}) {
  return Container(
    height: (height != null)
        ? AppUtils.appUtilsInstance.getPercentageSize(percentage: height)
        : double.infinity,
    width: (width != null)
        ? AppUtils.appUtilsInstance.getPercentageSize(percentage: width)
        : double.infinity,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(
            AppUtils.appUtilsInstance.getPercentageSize(
              percentage: bottomLeftRound ? size_2 : size_0,
            ),
          ),
          bottomRight: Radius.circular(
            AppUtils.appUtilsInstance.getPercentageSize(
              percentage: bottomRightRound ? size_2 : size_0,
            ),
          ),
          topRight: Radius.circular(
            AppUtils.appUtilsInstance.getPercentageSize(
              percentage: topRightRound ? size_2 : size_0,
            ),
          ),
          topLeft: Radius.circular(
            AppUtils.appUtilsInstance.getPercentageSize(
              percentage: topLeftRound ? size_2 : size_0,
            ),
          )),
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          colorGradient1,
          colorGradient2,
        ],
      ),
    ),
    child: child,
  );
}

// back icon button
Widget getBackButtonWidget({Function? callback}) {
  return InkWell(
    onTap: (callback == null)
        ? () {
            Get.back();
          }
        : () {
            callback();
          },
    child: Padding(
      padding: EdgeInsets.all(AppUtils.appUtilsInstance
          .getPercentageSize(ofWidth: false, percentage: size_1_5)),
      child: Icon(
        Icons.arrow_back_rounded,
        color: colorWhite,
        size: AppUtils.appUtilsInstance
            .getPercentageSize(ofWidth: false, percentage: size_4),
      ),
    ),
  );
}

//method to show or text and two vertical line left & right side
Widget dividerWithCenterText({String? centerTitle}) {
  return Row(
    children: <Widget>[
      SizedBox(
        width: AppUtils.appUtilsInstance
            .getPercentageSize(ofWidth: true, percentage: size_3),
      ),
      const Expanded(
        child: Divider(
          color: colorIconBlack,
        ),
      ),
      Padding(
        padding: EdgeInsets.symmetric(
            horizontal: AppUtils.appUtilsInstance
                .getPercentageSize(ofWidth: true, percentage: size_3)),
        child: textWidget(
          centerTitle ??
              "or" /*AppLocalizations.of(Get.context!).common.text.or*/,
          style: textCustom(color: colorIconBlack),
        ),
      ),
      const Expanded(
        child: Divider(
          color: colorIconBlack,
        ),
      ),
      SizedBox(
        width: AppUtils.appUtilsInstance
            .getPercentageSize(ofWidth: true, percentage: size_3),
      ),
    ],
  );
}

// fot custom dialog with blur background
getCustomDialogWidget({required Widget child, bool barrierDismissible = true}) {
  showDialog(
      barrierDismissible: barrierDismissible,
      context: Get.context!,
      builder: (BuildContext context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
          child: AlertDialog(
            backgroundColor: Colors.white,
            contentPadding: AppUtils.appUtilsInstance.commonPadding(),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                AppUtils.appUtilsInstance.getPercentageSize(
                  percentage: size_2_5,
                ),
              ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [child],
            ),
          ),
        );
      });
}

Widget commonDivider() {
  return const Divider(
    thickness: size_10,
    color: colorBackground,
  );
}

// text row with center dot
Widget centerDotTextsRow({
  required String value1,
  required String value2,
  TextStyle? value1Style,
  TextStyle? value2Style,
}) {
  return Row(
    children: [
      textWidget(value1, style: value1Style ?? textBlack()),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: size_8),
        child: Container(
          height: size_5,
          width: size_5,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: colorBlack,
          ),
        ),
      ),
      textWidget(value2, style: value2Style ?? textBlack(size: size_13)),
    ],
  );
}
