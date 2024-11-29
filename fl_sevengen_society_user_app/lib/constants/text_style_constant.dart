import 'package:fl_sevengen_society_user_app/constants/color.dart';
import 'package:flutter/material.dart';
import 'dimens.dart';
import 'font_constant.dart';

enum TextStyleEnum { regular, semiBold, bold }

extension TextStyleExtension on TextStyleEnum {
  FontWeight get value {
    switch (this) {
      case TextStyleEnum.regular:
        return FontWeight.w400;
      case TextStyleEnum.semiBold:
        return FontWeight.w600;
      case TextStyleEnum.bold:
        return FontWeight.w800;
      default:
        return FontWeight.w500;
    }
  }
}

TextStyle textCustom({
  double size = size_14,
  Color? color,
  TextStyleEnum textStyleEnum= TextStyleEnum.regular,
}) {
  return TextStyle(
      fontSize: size,
      fontWeight: textStyleEnum.value,
      color: color ?? colorPrimary,
      fontFamily: adelleSansEXT,
      decoration: TextDecoration.none);
}

TextStyle textWhite({
  double size = size_14,
  TextStyleEnum textStyleEnum= TextStyleEnum.regular,
}) {
  return TextStyle(
    fontSize: size,
    color: colorWhite,
    fontWeight: textStyleEnum.value,
    fontFamily: adelleSansEXT,
  );
}


TextStyle textGreen({
  double size = size_14,
  TextStyleEnum textStyleEnum= TextStyleEnum.regular,
}) {
  return TextStyle(
    fontSize: size,
    color: colorGreen,
    fontWeight: textStyleEnum.value,
    fontFamily: adelleSansEXT,
  );
}

TextStyle textGrey({
  double size = size_14,
  TextStyleEnum textStyleEnum = TextStyleEnum.regular,
}) {
  return TextStyle(
    fontSize: size,
    color: colorGrey,
    fontWeight: textStyleEnum.value,
    fontFamily: adelleSansEXT,
  );
}

TextStyle textLightGrey({
  double size = size_14,
  TextStyleEnum textStyleEnum = TextStyleEnum.regular,
}) {
  return TextStyle(
    fontSize: size,
    color: colorLightGrey,
    fontWeight: textStyleEnum.value,
    fontFamily: adelleSansEXT,
  );
}



TextStyle textLightBlack({
  double size = size_14,
  TextStyleEnum textStyleEnum = TextStyleEnum.regular,
}) {
  return TextStyle(
    fontSize: size,
    color: colorLightBlack,
    fontWeight: textStyleEnum.value,
    fontFamily: adelleSansEXT,
  );
}

TextStyle textDisabled({
  double size = size_14,
  TextStyleEnum textStyleEnum = TextStyleEnum.regular,
}) {
  return TextStyle(
    fontSize: size,
    color: colorDisabled,
    fontWeight: textStyleEnum.value,
    fontFamily: adelleSansEXT,
  );
}

TextStyle textBlack({
  double size = size_14,
  TextStyleEnum textStyleEnum = TextStyleEnum.regular,
}) {
  return TextStyle(
    fontSize: size,
    color: colorTextBlack,
    fontWeight: textStyleEnum.value,
    fontFamily: adelleSansEXT,
  );
}

TextStyle textUnderline({
  double size = size_18,
  Color textColor = colorWhite,
  TextStyleEnum textStyleEnum= TextStyleEnum.regular,
}) {
  return TextStyle(
      fontSize: size,
      fontWeight: textStyleEnum.value,
      color: textColor,
      fontFamily: adelleSansEXT,
      decoration: TextDecoration.underline);
}

TextStyle textColorPrimary({
  double size = size_14,
  TextStyleEnum textStyleEnum = TextStyleEnum.regular,
}) {
  return TextStyle(
    fontSize: size,
    color: colorPrimary,
    fontWeight: textStyleEnum.value,
    fontFamily: adelleSansEXT,
  );
}
