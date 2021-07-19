import 'package:flutter/material.dart';
import 'package:gin_finans_app/src/values/app_colors.dart';

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
