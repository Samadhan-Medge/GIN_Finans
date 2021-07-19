import 'package:flutter/material.dart';
import 'package:gin_finans_app/src/listeners/sub_screen_callback_listener.dart';
import 'package:gin_finans_app/src/values/app_colors.dart';
import 'package:gin_finans_app/src/values/dimensions.dart';

import 'custom_ui/input_fields.dart';
import 'custom_ui/next_button.dart';

class CreatePasswordScreen extends StatefulWidget {
  final SubScreenCallbackListener subScreenCallbackListener;

  CreatePasswordScreen({required this.subScreenCallbackListener});

  @override
  _CreatePasswordScreenState createState() => _CreatePasswordScreenState();
}

class _CreatePasswordScreenState extends State<CreatePasswordScreen> {
  bool _showPassword = false;
  bool _containLowerCaseLetter = false;
  bool _containUpperCaseLetter = false;
  bool _containNumber = false;
  bool _pwdLength = false;
  String? _pwdComplexity;
  TextEditingController _pwdController = new TextEditingController();
  Color? complexityColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: ListView(
                shrinkWrap: false,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Create Password", style: Theme.of(context).textTheme.bodyText1),
                        SizedBox(height: 10.0),
                        Text("Password will be used to login to account",
                            style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: AppDimensions.textSizeSmall)),
                        SizedBox(height: 50.0),
                        InputFieldArea(
                            hint: "Create Password",
                            obscure: _showPassword,
                            textEditingController: _pwdController,
                            maxLength: 20,
                            isEmpty: true,
                            textAction: TextInputAction.go,
                            onValueChanged: (newValue) {
                              checkPasswordValidation(newValue);
                            },
                            onFieldError: (newFocus) {},
                            inputType: TextInputType.text,
                            suffixIcon: IconButton(
                              icon: Icon(
                                Icons.remove_red_eye,
                                color: this._showPassword ? Colors.blue : Colors.grey,
                              ),
                              onPressed: () {
                                setState(() => this._showPassword = !this._showPassword);
                              },
                            )),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Text(
                              "Complexity: ",
                              style: Theme.of(context).textTheme.headline5!.copyWith(color: AppColors.colorWhite, fontSize: 16),
                            ),
                            Text(_pwdComplexity ?? "",
                                style: Theme.of(context).textTheme.headline5!.copyWith(color: complexityColor ?? AppColors.colorWhite, fontSize: 14)),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            PasswordComplexityCheckWidget(isContained: _containLowerCaseLetter, title: 'a', subTitle: 'Lowercase'),
                            PasswordComplexityCheckWidget(isContained: _containUpperCaseLetter, title: 'A', subTitle: 'Uppercase'),
                            PasswordComplexityCheckWidget(isContained: _containNumber, title: '123', subTitle: 'Number'),
                            PasswordComplexityCheckWidget(isContained: _pwdLength, title: '9+', subTitle: 'Characters'),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Align(
            alignment: FractionalOffset.bottomCenter,
            child: NextButton(onClick: () {
              widget.subScreenCallbackListener.redirectToNextScreen();
            }),
          ),
        ],
      ),
    );
  }

  void checkPasswordValidation(String? newValue) {
    if (newValue != null && newValue.isNotEmpty) {
      String smallCasePattern = r'([a-z])';
      String upperCasePattern = r'([A-Z])';
      String numberPattern = r'([0-9])';
      setState(() {
        _containLowerCaseLetter = newValue.contains(RegExp(smallCasePattern));
        _containUpperCaseLetter = newValue.contains(RegExp(upperCasePattern));
        _containNumber = newValue.contains(RegExp(numberPattern));
        _pwdLength = newValue.length > 9;
      });

      String regex = '^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[-+_!@#%^&*., ?])';
      if (_containLowerCaseLetter && _containUpperCaseLetter && _containNumber && _pwdLength && newValue.contains(RegExp(regex))) {
        _pwdComplexity = "Strong";
        complexityColor = Colors.orange;
      } else if (_containLowerCaseLetter && _containUpperCaseLetter && _containNumber && _pwdLength) {
        _pwdComplexity = "Good";
        complexityColor = Colors.tealAccent;
      } else if (_containLowerCaseLetter && _containUpperCaseLetter && _containNumber) {
        _pwdComplexity = "Weak";
        complexityColor = Colors.yellow;
      } else {
        _pwdComplexity = "Very Weak";
        complexityColor = Colors.red;
      }

      setState(() {});
    } else {
      setState(() {
        _containLowerCaseLetter = false;
        _containUpperCaseLetter = false;
        _containNumber = false;
        _pwdLength = false;
        _pwdComplexity = "";
      });
    }
  }

  bool isValidPassword() {
    return _containLowerCaseLetter && _containUpperCaseLetter && _containNumber && _pwdLength;
  }
}

class PasswordComplexityCheckWidget extends StatelessWidget {
  final bool isContained;
  final String title;
  final String subTitle;

  PasswordComplexityCheckWidget({
    required this.isContained,
    required this.title,
    required this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        isContained
            ? _buildCircle()
            : Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.headline5!.copyWith(color: AppColors.colorWhite),
                )),
        Text(
          subTitle,
          style: Theme.of(context).textTheme.headline5!.copyWith(color: AppColors.colorWhite, fontSize: 12),
        ),
      ],
    );
  }

  Widget _buildCircle() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12.0),
      width: 24,
      height: 24,
      child: AnimatedContainer(
        curve: Curves.fastOutSlowIn,
        duration: kThemeAnimationDuration,
        decoration: BoxDecoration(
          color: Colors.green,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Icon(
            Icons.check,
            color: AppColors.colorWhite,
            size: 16.0,
          ),
        ),
      ),
    );
  }
}
