import 'package:flutter/material.dart';
import 'package:gin_finans_app/src/listeners/sub_screen_callback_listener.dart';
import 'package:gin_finans_app/src/ui/email_registration_screen.dart';
import 'package:gin_finans_app/src/ui/personal_information_screen.dart';
import 'package:gin_finans_app/src/ui/schedule_video_call_screen.dart';

import 'create_password_screen.dart';
import 'custom_ui/stepper_view_widget.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SubScreenCallbackListener {
  int _index = 0;
  List<StepperViewStep> _stepInfoList = [
    StepperViewStep(isActive: false, state: StepperViewStepState.indexed),
    StepperViewStep(isActive: false, state: StepperViewStepState.indexed),
    StepperViewStep(isActive: false, state: StepperViewStepState.indexed),
    StepperViewStep(isActive: false, state: StepperViewStepState.indexed),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: _index != 0
          ? AppBar(
              title: Text("Create Account", style: Theme.of(context).textTheme.headline3),
              backgroundColor: Theme.of(context).colorScheme.primary,
              shadowColor: Colors.transparent,
              leading: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    goToPreviousStep();
                  }),
            )
          : null,
      body: Container(
        color: Theme.of(context).colorScheme.background,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Visibility(visible:_index == 0,child: Container(height: 50, color: Theme.of(context).colorScheme.primary)),
            StepperView(
              physics: const BouncingScrollPhysics(),
              currentStep: _index,
              onStepTapped: (index) {
                setState(() {
                  _index = index;
                });
              },
              steps: _stepInfoList,
            ),
            Expanded(child: getCurrentScreen(_index)),
          ],
        ),
      ),
    );
  }

  void goToPreviousStep() {
    if (_index > 0) {
      setState(() {
        _index--;
        _stepInfoList[_index].state = StepperViewStepState.indexed;
      });
    }
  }

  void goToNextStep() {
    setState(() {
      _stepInfoList[_index].state = StepperViewStepState.complete;
      _index++;
    });
  }

  /*
   * Method to return current screen to replace at container basis on index
   */
  Widget getCurrentScreen(int index) {
    switch (index) {
      case 0:
        return EmailRegistrationScreen(subScreenCallbackListener: this);
      case 1:
        return CreatePasswordScreen(subScreenCallbackListener: this);
      case 2:
        return PersonalInformationScreen(subScreenCallbackListener: this);
      case 3:
        return ScheduleVideoCallScreen(subScreenCallbackListener: this);
      default:
        return Container();
    }
  }

  @override
  redirectToNextScreen(int currentScreenIndex) {
    goToNextStep();
  }

  @override
  redirectToPreviousScreen(int currentScreenIndex) {
    _index = currentScreenIndex - 1;
    goToPreviousStep();
  }
}
