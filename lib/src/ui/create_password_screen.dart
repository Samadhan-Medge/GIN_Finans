import 'package:flutter/material.dart';
import 'package:gin_finans_app/src/blocs/create_password_bloc.dart';
import 'package:gin_finans_app/src/enums/enum_password_complexity.dart';
import 'package:gin_finans_app/src/listeners/sub_screen_callback_listener.dart';
import 'package:gin_finans_app/src/values/app_colors.dart';
import 'package:gin_finans_app/src/values/dimensions.dart';

import 'custom_ui/input_fields.dart';
import 'custom_ui/next_button.dart';
import 'custom_ui/password_complexity_check_widget.dart';

class CreatePasswordScreen extends StatefulWidget {
  final SubScreenCallbackListener subScreenCallbackListener;

  CreatePasswordScreen({required this.subScreenCallbackListener});

  @override
  _CreatePasswordScreenState createState() => _CreatePasswordScreenState();
}

class _CreatePasswordScreenState extends State<CreatePasswordScreen> {
  bool _showPassword = false;
  TextEditingController _pwdController = new TextEditingController();
  PasswordComplexity passwordComplexity = PasswordComplexity.NotSet;

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
                        SizedBox(height: 10.0),
                        InputFieldArea(
                            hint: "Create Password",
                            obscure: _showPassword,
                            textEditingController: _pwdController,
                            maxLength: 20,
                            isEmpty: true,
                            textAction: TextInputAction.go,
                            onValueChanged: (newValue) {
                              passwordComplexity = bloc.checkPasswordComplexity(newValue);
                              setState(() {});
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
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Text(
                              "Complexity: ",
                              style: Theme.of(context).textTheme.headline5!.copyWith(color: AppColors.colorWhite, fontSize: 16),
                            ),
                            Text(passwordComplexity.getName,
                                style: Theme.of(context).textTheme.headline5!.copyWith(color: passwordComplexity.getColor, fontSize: 14)),
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            PasswordComplexityCheckWidget(isContained: bloc.containLowerCaseLetter, title: 'a', subTitle: 'Lowercase'),
                            PasswordComplexityCheckWidget(isContained: bloc.containUpperCaseLetter, title: 'A', subTitle: 'Uppercase'),
                            PasswordComplexityCheckWidget(isContained: bloc.containNumber, title: '123', subTitle: 'Number'),
                            PasswordComplexityCheckWidget(isContained: bloc.pwdLength, title: '9+', subTitle: 'Characters'),
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
              if (bloc.isValidPassword()) widget.subScreenCallbackListener.redirectToNextScreen();
            }),
          ),
        ],
      ),
    );
  }
}
