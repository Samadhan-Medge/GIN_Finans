import 'package:flutter/material.dart';
import 'package:gin_finans_app/src/values/app_colors.dart';
import 'package:gin_finans_app/src/values/dimensions.dart';

class CustomThemeData {
  final BuildContext? context;

  CustomThemeData({this.context});

  ThemeData get themeData {
    /// Create a TextTheme and ColorScheme, that we can use to generate ThemeData
    TextTheme txtTheme = TextTheme(
      headline1: TextStyle(
        color: AppColors.labelBlack,
        fontSize: AppDimensions.textSizeXXExtraLarge,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.bold,
      ),
      headline2: TextStyle(
        color: AppColors.labelBlack,
        fontSize: AppDimensions.textSizePrimary,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.bold,
      ),
      headline3: TextStyle(
        color: AppColors.colorWhite,
        fontSize: AppDimensions.textSizeMedium,
        fontStyle: FontStyle.normal,
      ),
      headline4: TextStyle(
        color: AppColors.labelBlack,
        fontSize: AppDimensions.textSizeSmall,
        fontStyle: FontStyle.normal,
      ),
      headline5: TextStyle(
        color: AppColors.labelBlack,
        fontSize: 18,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w500,
      ),
      headline6: TextStyle(
        color: AppColors.labelBlack,
        fontSize: 20,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.bold,
      ),
      bodyText1: TextStyle(
        color: AppColors.colorWhite,
        fontSize: AppDimensions.textSizePrimary,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w400,
      ),
      bodyText2: TextStyle(
        color: AppColors.colorWhite,
        fontSize: AppDimensions.textSizeMedium,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w400,
      ),
      button: TextStyle(
        color: AppColors.colorPrimary,
        fontStyle: FontStyle.normal,
        fontSize: AppDimensions.textSizeSecondary,
        fontWeight: FontWeight.w400,
      ),
    );

    ColorScheme colorScheme = ColorScheme(
        // Decide how you want to apply your own custom them, to the MaterialApp
        brightness: Brightness.light,
        primary: AppColors.colorPrimary,
        primaryVariant: AppColors.colorPrimary,
        secondary: AppColors.colorPrimary,
        secondaryVariant: AppColors.colorPrimary,
        background: AppColors.colorPrimary,
        onBackground:AppColors.colorPrimary,
        surface:AppColors.colorPrimary,
        onSurface: AppColors.lightBlue,
        onError: AppColors.fieldErrorTextColor,
        onPrimary: Colors.white,
        onSecondary: Colors.grey,
        error: AppColors.fieldErrorTextColor);

    return ThemeData(
      textTheme: txtTheme,
      colorScheme: colorScheme,
      fontFamily: 'Roboto',
      primaryColor: AppColors.colorPrimary,
      errorColor: AppColors.fieldErrorTextColor,
      backgroundColor: AppColors.colorPrimary,
      toggleableActiveColor: AppColors.colorPrimary,
    );
  }
}
