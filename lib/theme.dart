import 'package:flutter/material.dart';

class Sizes {
  static const logoSize = 150.0;
  static const profileImageSize = 256.0;
  static const profileTopMargin = 50.0;

  static const mainContainerMargin = 10.0;
  static const mainContainerPadding = 10.0;

  static const bottomNavButtonSize = 20.0;

  static const buttonIconSize = 20.0;
  static const buttonPadding = 24.0;
  static const buttonPaddingAlternate = 48.0;

  static const bodyLargeFontSize = 18.0;
  static const bodyMediumFontSize = 16.0;

  static const textThemeLetterSpacing = 1.5;

  static const loginPageContainerPadding = 30.0;

  static const gridViewPadding = 20.0;
  static const gridViewCrossAxisSpacing = 10.0;
  static const gridViewCrossAxisCount = 2;

  static const companyCardFlexValue = 3;
  static const companyCardTitlePaddingLeft = 10.0;
  static const companyCardTitlePaddingRight = 10.0;
  static const companyCardTitleHeight = 1.5;

  static const companyDetailsTitleHeight = 2.0;
  static const companyDetailsFontSize = 20.0;
  static const companyDetailsTitlePadding = 10.0;

  static const companyDrawerItemPaddingTop = 10.0;
  static const companyDrawerItemPaddingLeft = 10.0;
  static const companyDrawerItemFontSize = 20.0;

  static const companyAddScreenParagraphPadding = 10.0;

  static const formAddScreenContainerPadding = 20.0;
  static const formFieldContainerPadding = 10.0;

  static const licenseDrawerElevation = 4.0;
  static const licenseDrawerMargin = 4.0;
  static const licenseDrawerPadding = 8.0;
  static const licenseIconSize = 40.0;

  static const progressBarDefaultHeight = 12.0;
  static const progressBarContainerPadding = 10.0;
}

var appTheme = ThemeData(
  iconTheme: const IconThemeData(
    color: Colors.white,
  ),
  bottomAppBarTheme: const BottomAppBarTheme(
    color: Colors.black87,
  ),
  brightness: Brightness.dark,
  textTheme: const TextTheme(
    bodyLarge: TextStyle(fontSize: Sizes.bodyLargeFontSize),
    bodyMedium: TextStyle(fontSize: Sizes.bodyMediumFontSize),
    labelLarge: TextStyle(
      letterSpacing: Sizes.textThemeLetterSpacing,
      fontWeight: FontWeight.bold,
    ),
    displayLarge: TextStyle(
      fontWeight: FontWeight.bold,
    ),
    titleMedium: TextStyle(
      color: Colors.grey,
    ),
  ),
  buttonTheme: const ButtonThemeData(),
);
