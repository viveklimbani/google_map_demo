import 'package:flutter/material.dart';

import 'colors.dart';
import 'package:practice_app/common/utils/dimen.dart' as Dimens;

const PoppinsFamily = "Poppins";

class TextStyles {
  static const String defaultFontFamily = PoppinsFamily;

  ///Custom Styles
  static const _titleStyle = TextStyle(
      fontSize: Dimens.TextSize.title,
      fontFamily: defaultFontFamily,
      fontWeight: FontWeight.w500,
      color: MAColors.whiteColor);

  static const _heading1 = TextStyle(
      fontSize: Dimens.TextSize.heading1,
      fontFamily: defaultFontFamily,
      fontWeight: FontWeight.w400,
      color: MAColors.whiteColor);

  static const _heading2 = TextStyle(
      fontSize: Dimens.TextSize.heading2,
      fontFamily: defaultFontFamily,
      fontWeight: FontWeight.w400,
      color: MAColors.whiteColor);

  static const _heading3 = TextStyle(
      fontSize: Dimens.TextSize.heading3,
      fontFamily: defaultFontFamily,
      fontWeight: FontWeight.w400,
      color: MAColors.whiteColor);

  static const _heading4 = TextStyle(
      fontSize: Dimens.TextSize.heading4,
      fontFamily: defaultFontFamily,
      fontWeight: FontWeight.w400,
      color: MAColors.whiteColor);

  static const _heading5 = TextStyle(
      fontSize: Dimens.TextSize.heading5,
      fontFamily: defaultFontFamily,
      fontWeight: FontWeight.w400,
      color: MAColors.whiteColor);

  static const textFieldStyle = TextStyle(
      fontSize: Dimens.TextSize.large,
      fontFamily: defaultFontFamily,
      fontWeight: FontWeight.w400,
      color: MAColors.whiteColor);

  static const semiBoldText = TextStyle(
      fontSize: Dimens.TextSize.xlarge,
      fontFamily: defaultFontFamily,
      fontWeight: FontWeight.w500,
      color: MAColors.lightOrangeColor);

  static const smallText = TextStyle(
      fontSize: Dimens.TextSize.small,
      fontFamily: defaultFontFamily,
      fontWeight: FontWeight.w500,
      color: MAColors.whiteColor);

  static const smallLightText = TextStyle(
      fontSize: Dimens.TextSize.small,
      fontFamily: defaultFontFamily,
      fontWeight: FontWeight.w300,
      color: MAColors.whiteColor);

  static const secondaryTextStyle = TextStyle(
      fontSize: Dimens.TextSize.font11,
      fontFamily: defaultFontFamily,
      fontWeight: FontWeight.w400,
      color: MAColors.secondaryGreyTextColor);

  static const textFieldLabelStyle = TextStyle(
      fontSize: Dimens.TextSize.xsmall,
      fontFamily: defaultFontFamily,
      fontWeight: FontWeight.w300,
      color: MAColors.whiteColor);

  static const regularTextStyle = TextStyle(
      fontSize: Dimens.TextSize.normal,
      fontFamily: defaultFontFamily,
      fontWeight: FontWeight.w600,
      color: MAColors.whiteColor);

  static const mediumTextStyle = TextStyle(
      fontSize: Dimens.TextSize.xlarge,
      fontFamily: defaultFontFamily,
      fontWeight: FontWeight.w500,
      color: MAColors.whiteColor);

  static const mediumBoldTextStyle = TextStyle(
      fontSize: Dimens.TextSize.xlarge,
      fontFamily: defaultFontFamily,
      fontWeight: FontWeight.w600,
      color: MAColors.whiteColor);

  static const stepperRegularTextStyle = TextStyle(
      fontSize: Dimens.TextSize.normal,
      fontFamily: defaultFontFamily,
      fontWeight: FontWeight.w400,
      color: MAColors.whiteColor);

  static const stepperSmallText = TextStyle(
      fontSize: Dimens.TextSize.small,
      fontFamily: defaultFontFamily,
      fontWeight: FontWeight.w400,
      color: MAColors.whiteColor);

  static const buttonTextStyle = TextStyle(
      fontSize: Dimens.TextSize.font13,
      fontFamily: defaultFontFamily,
      fontWeight: FontWeight.w400,
      color: MAColors.whiteColor);

  static const regularSmallTextStyle = TextStyle(
      fontSize: Dimens.TextSize.font13,
      fontFamily: defaultFontFamily,
      fontWeight: FontWeight.w400,
      color: MAColors.whiteColor);

  static const appbarTextStyle = TextStyle(
      fontSize: Dimens.TextSize.font18,
      fontFamily: defaultFontFamily,
      fontWeight: FontWeight.w500,
      color: MAColors.whiteColor);

  ///Helvetica font family text style
  static const alterBoxTitleStyle = TextStyle(
      fontSize: Dimens.TextSize.font18,
      fontWeight: FontWeight.w900,
      fontFamily: defaultFontFamily,
      color: MAColors.whiteColor);

  ///
  static const regularHelveticaText = TextStyle(
    fontSize: Dimens.TextSize.font13,
    fontFamily: defaultFontFamily,
    color: MAColors.whiteColor,
  );

  ///Regular styles
  static const _small = TextStyle(
    fontSize: Dimens.TextSize.small,
    fontFamily: defaultFontFamily,
    fontWeight: FontWeight.w400,
    color: MAColors.whiteColor,
  );
  static const _xsmall = TextStyle(
    fontSize: Dimens.TextSize.xsmall,
    fontFamily: defaultFontFamily,
    fontWeight: FontWeight.w400,
    color: MAColors.whiteColor,
  );

  static const _xxsmall = TextStyle(
    fontSize: Dimens.TextSize.xxsmall,
    fontFamily: defaultFontFamily,
    fontWeight: FontWeight.w400,
    color: MAColors.whiteColor,
  );

  static const _normal = TextStyle(
    fontSize: Dimens.TextSize.normal,
    fontFamily: defaultFontFamily,
    fontWeight: FontWeight.w400,
    color: MAColors.whiteColor,
  );

  static const _large = TextStyle(
    fontSize: Dimens.TextSize.large,
    fontFamily: defaultFontFamily,
    fontWeight: FontWeight.w400,
    color: MAColors.whiteColor,
  );

  static const _xlarge = TextStyle(
    fontSize: Dimens.TextSize.xlarge,
    fontFamily: defaultFontFamily,
    fontWeight: FontWeight.w400,
    color: MAColors.whiteColor,
  );

  static const _xxlarge = TextStyle(
    fontSize: Dimens.TextSize.xxlarge,
    fontFamily: defaultFontFamily,
    fontWeight: FontWeight.w400,
    color: MAColors.whiteColor,
  );

  static const _xxxlarge = TextStyle(
    fontSize: Dimens.TextSize.xxxlarge,
    fontFamily: defaultFontFamily,
    fontWeight: FontWeight.w400,
    color: MAColors.whiteColor,
  );

  static TextStyle get Title => _titleStyle;
  static TextStyle get heading1 => _heading1;
  static TextStyle get heading2 => _heading2;
  static TextStyle get heading3 => _heading3;
  static TextStyle get heading4 => _heading4;
  static TextStyle get heading5 => _heading5;
  static TextStyle get small => _small;
  static TextStyle get xSmall => _xsmall;
  static TextStyle get xxSmall => _xxsmall;
  static TextStyle get normal => _normal;
  static TextStyle get large => _large;
  static TextStyle get xLarge => _xlarge;
  static TextStyle get xxLarge => _xxlarge;
  static TextStyle get xxxLarge => _xxxlarge;
}

