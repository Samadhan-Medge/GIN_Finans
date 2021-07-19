import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gin_finans_app/src/listeners/sub_screen_callback_listener.dart';
import 'package:gin_finans_app/src/ui/custom_ui/next_button.dart';
import 'package:gin_finans_app/src/values/app_colors.dart';
import 'package:gin_finans_app/src/values/dimensions.dart';

import 'custom_ui/clipper_view.dart';
import 'custom_ui/input_fields.dart';

class EmailRegistrationScreen extends StatefulWidget {
  final SubScreenCallbackListener subScreenCallbackListener;

  EmailRegistrationScreen({required this.subScreenCallbackListener});

  @override
  _EmailRegistrationScreenState createState() => _EmailRegistrationScreenState();
}

class _EmailRegistrationScreenState extends State<EmailRegistrationScreen> {
  TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.lightBlue,
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
                    Container(
                      color: AppColors.lightBlue,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomPaint(
                            child: Container(
                              width: double.infinity,
                              height: 50.0,
                            ),
                            painter: CustomPath(color: Theme.of(context).colorScheme.primary, radius: AppDimensions.clipperViewRadius),
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(AppDimensions.fieldSpacing),
                            child: RichText(
                              text: TextSpan(
                                  text: 'Welcome to\nGIN ',
                                  style: Theme.of(context).textTheme.headline1!.copyWith(color: AppColors.labelBlack, fontWeight: FontWeight.bold),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: 'Finans',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline1!
                                          .copyWith(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold),
                                    )
                                  ]),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: AppDimensions.fieldSpacing),
                            child: Text(
                              "Welcome to The Bank of The Future. Manage and track yours accounts on th go",
                              style: Theme.of(context).textTheme.bodyText1!.copyWith(color: AppColors.labelBlack),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(AppDimensions.fieldSpacing),
                            child: InputFieldArea(
                                hint: "Email",
                                obscure: false,
                                textEditingController: _emailController,
                                maxLength: 64,
                                isEmpty: true,
                                textAction: TextInputAction.go,
                                onValueChanged: (newValue) {},
                                onFieldError: (newFocus) {},
                                inputType: TextInputType.emailAddress,
                                prefixIcon: IconButton(
                                  icon: Icon(
                                    Icons.email_outlined,
                                    color: AppColors.darkGrey,
                                  ),
                                  onPressed: () {},
                                )),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )),
          Align(
            alignment: FractionalOffset.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: NextButton(onClick: () {
                widget.subScreenCallbackListener.redirectToNextScreen(0);
              }),
            ),
          ),
        ],
      ),
    );
  }
}
