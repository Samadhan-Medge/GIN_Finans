import 'package:flutter/material.dart';
import 'package:gin_finans_app/src/values/app_colors.dart';
import 'package:gin_finans_app/src/values/app_strings.dart';

enum PasswordComplexity { Strong, Good, Weak, VeryWeak, NotSet }

extension PasswordComplexityColors on PasswordComplexity {
  Color get getColor {
    switch (this) {
      case PasswordComplexity.Strong:
        return AppColors.colorPasswordCompxityStrong;
      case PasswordComplexity.Good:
        return AppColors.colorPasswordCompxityGood;
      case PasswordComplexity.Weak:
        return AppColors.colorPasswordCompxityWeak;
      case PasswordComplexity.VeryWeak:
        return AppColors.colorPasswordCompxityVeryWeak;
      default:
        return AppColors.colorPasswordCompxityVeryWeak;
    }
  }
}

extension PasswordComplexityNames on PasswordComplexity {
  String get getName {
    switch (this) {
      case PasswordComplexity.Strong:
        return AppStrings.strong;
      case PasswordComplexity.Good:
        return AppStrings.good;
      case PasswordComplexity.Weak:
        return AppStrings.weak;
      case PasswordComplexity.VeryWeak:
        return AppStrings.veryWeak;
      default:
        return '';
    }
  }
}
