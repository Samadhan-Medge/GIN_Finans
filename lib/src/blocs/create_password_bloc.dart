import 'package:gin_finans_app/src/enums/enum_password_complexity.dart';

class CreatePasswordBloc {
  bool containLowerCaseLetter = false;
  bool containUpperCaseLetter = false;
  bool containNumber = false;
  bool pwdLength = false;

  String? pwdComplexity;

  /*
    Method to to check password complexity
   */
  PasswordComplexity checkPasswordComplexity(String? newValue) {
    if (newValue != null && newValue.isNotEmpty) {
      String smallCasePattern = r'([a-z])';
      String upperCasePattern = r'([A-Z])';
      String numberPattern = r'([0-9])';
      containLowerCaseLetter = newValue.contains(RegExp(smallCasePattern));
      containUpperCaseLetter = newValue.contains(RegExp(upperCasePattern));
      containNumber = newValue.contains(RegExp(numberPattern));
      pwdLength = newValue.length > 9;

      String regex = '^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[-+_!@#%^&*., ?])';
      if (containLowerCaseLetter && containUpperCaseLetter && containNumber && pwdLength && newValue.contains(RegExp(regex)))
        return PasswordComplexity.Strong;
      else if (containLowerCaseLetter && containUpperCaseLetter && containNumber && pwdLength)
        return PasswordComplexity.Good;
      else if (containLowerCaseLetter && containUpperCaseLetter && containNumber)
        return PasswordComplexity.Weak;
      else
        return PasswordComplexity.VeryWeak;
    } else {
        containLowerCaseLetter = false;
        containUpperCaseLetter = false;
        containNumber = false;
        pwdLength = false;
        pwdComplexity = "";
        return PasswordComplexity.VeryWeak;
    }
  }

  bool isValidPassword() {
    return containLowerCaseLetter && containUpperCaseLetter && containNumber && pwdLength;
  }
}

final bloc = CreatePasswordBloc();
