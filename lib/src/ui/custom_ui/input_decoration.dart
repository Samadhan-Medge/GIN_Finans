import 'package:flutter/material.dart';
import 'package:gin_finans_app/src/values/app_colors.dart';

class AppInputDecoration {
  InputDecoration getDecoration(
      {String? prefix,
      Widget? prefixIcon,
      Widget? suffixIcon,
      required String hint,
      Widget? suffix,
      String? counterText,
      FloatingLabelBehavior? floatingLabelBehavior,
      double? borderRadius,
      EdgeInsetsGeometry? contentPadding}) {
    return InputDecoration(
        floatingLabelBehavior: floatingLabelBehavior ?? FloatingLabelBehavior.auto,
        fillColor: AppColors.colorWhite,
        filled: true,
        errorMaxLines: 2,
        prefixText: prefix,
        prefixIcon: prefixIcon != null
            ? new Container(
                child: prefixIcon,
              )
            : null,
        counterText: "",
        suffixIcon: suffixIcon != null
            ? new Container(
                child: suffixIcon,
              )
            : null,
        suffix: suffix,
        labelText: hint,
        labelStyle: TextStyle(
          color: AppColors.darkGrey,
          fontSize: 14.0,
        ),
        contentPadding: contentPadding == null ? EdgeInsets.all(16) : contentPadding,
        errorStyle: TextStyle(
          color: AppColors.fieldErrorTextColor,
          fontSize: 14.0,
        ),
        hintStyle: TextStyle(color: AppColors.labelBlack),
        border: getOutlineBorder(borderRadius!),
        focusedBorder: getOutlineBorder(borderRadius),
        enabledBorder: getOutlineBorder(borderRadius));
  }

  InputBorder getOutlineBorder(double borderRadius) {
    return OutlineInputBorder(borderRadius: BorderRadius.circular(borderRadius), borderSide: BorderSide(width: 5.0, color: AppColors.colorWhite));
  }

  EdgeInsetsGeometry getCommonPaddingForField() {
    return EdgeInsets.only(left: 0.0, top: 12, right: 0.0);
  }
}
