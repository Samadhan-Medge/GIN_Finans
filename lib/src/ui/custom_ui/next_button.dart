import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gin_finans_app/src/values/app_colors.dart';
import 'package:gin_finans_app/src/values/dimensions.dart';

class NextButton extends StatelessWidget {
  final Function onClick;

  NextButton({required this.onClick});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        getPlatformSpecificButton(context, onClick),
      ],
    );
  }
}

Widget getPlatformSpecificButton(BuildContext context, Function onClick) {
  if (Platform.isIOS) {
    return CupertinoButton(
      child: Text(
        'Next',
        style: TextStyle(
          fontSize: 18,
          color: Colors.white,
        ),
      ),
      color: Theme.of(context).colorScheme.secondary,
      onPressed: () {
        onClick();
      },
    );
  } else {
    return RaisedButton(
      padding: EdgeInsets.all(10.0),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.buttonCornerRadius)),
      color: Theme.of(context).colorScheme.primary.withAlpha(140),
      textColor: AppColors.colorWhite,
      onPressed: () {
        onClick();
      },
      child: Text(
        'Next',
        style: TextStyle(fontSize: 18),
      ),
    );
  }
}
