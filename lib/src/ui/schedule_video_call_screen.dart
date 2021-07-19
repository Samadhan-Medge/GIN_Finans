import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gin_finans_app/src/listeners/sub_screen_callback_listener.dart';
import 'package:gin_finans_app/src/utils/utils.dart';
import 'package:gin_finans_app/src/values/app_colors.dart';
import 'package:gin_finans_app/src/values/dimensions.dart';

import 'custom_ui/input_decoration.dart';
import 'custom_ui/next_button.dart';

class ScheduleVideoCallScreen extends StatefulWidget {
  final SubScreenCallbackListener subScreenCallbackListener;

  ScheduleVideoCallScreen({required this.subScreenCallbackListener});

  @override
  _ScheduleVideoCallScreenState createState() => _ScheduleVideoCallScreenState();
}

class _ScheduleVideoCallScreenState extends State<ScheduleVideoCallScreen> with TickerProviderStateMixin {
  TextEditingController _dateController = TextEditingController();
  TextEditingController _timeController = TextEditingController();
  String? _hour, _minute, _time;
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay(hour: 00, minute: 00);
  AnimationController? _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    )
      ..forward()
      ..repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0.0),
            child: Stack(
              children: [
                Container(
                  height: 100,
                  width: 70,
                  alignment: Alignment.centerLeft,
                  child: Align(
                    alignment: Alignment.center,
                    child: AnimatedBuilder(
                      animation: _animationController!,
                      builder: (context, child) {
                        return Container(
                          decoration: ShapeDecoration(
                            color: Colors.white.withOpacity(0.5),
                            shape: CircleBorder(),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(10.0 * _animationController!.value),
                            child: child,
                          ),
                        );
                      },
                      child: Container(
                        decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: CircleBorder(),
                        ),
                        child: IconButton(
                          onPressed: () {},
                          color: Colors.blue,
                          icon: Icon(Icons.date_range_sharp, size: 24),
                        ),
                      ),
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 100,
                    ),
                    Text('Schedule Video Call', style: Theme.of(context).textTheme.bodyText1),
                    SizedBox(height: 10.0),
                    Text('Choose the date and time that you preferred, we will send a link via email to make a video call on schedule date and time',
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: AppDimensions.textSizeSmall)),
                    SizedBox(height: 30),
                    getDateDropdownMenu(hint: 'Date', dropdownHint: '- Choose Date -', flagToShowTime: false, textEditingController: _dateController),
                    SizedBox(height: 30),
                    getDateDropdownMenu(hint: 'Time', dropdownHint: '- Choose Time -', flagToShowTime: true, textEditingController: _timeController),
                  ],
                ),
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
    );
  }

  Widget getDateDropdownMenu({required String hint, String? dropdownHint, TextEditingController? textEditingController, bool? flagToShowTime}) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white, width: 10.0),
        borderRadius: BorderRadius.circular(14),
      ),
      child: InputDecorator(
          decoration: AppInputDecoration().getDecoration(
            hint: hint,
            contentPadding: EdgeInsets.all(0.0),
            borderRadius: 2,
          ),
          child: TextFormField(
            decoration: InputDecoration(
                contentPadding: null,
                hintText: dropdownHint,
                border: InputBorder.none,
                hintStyle: TextStyle(
                  color: AppColors.labelBlack,
                ),
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                suffixIcon: IconButton(
                  icon: Icon(Icons.keyboard_arrow_down),
                  onPressed: null,
                )),
            readOnly: true,
            controller: textEditingController,
            onTap: () {
              getCalenderView(flagToShowTime!);
            },
            onChanged: (value) {},
          )),
    );
  }

  getCalenderView(bool flagToShowTime) {
    if (Platform.isIOS) {
      _showIosDatePicker(flagToShowTime);
    } else {
      if (flagToShowTime) {
        _selectTime(context);
      } else {
        _selectDate(context);
      }
    }
  }

  _showIosDatePicker(bool flagTimeMode) {
    return CupertinoDatePicker(
      mode: flagTimeMode ? CupertinoDatePickerMode.time : CupertinoDatePickerMode.date,
      initialDateTime: selectedDate,
      onDateTimeChanged: (DateTime newDateTime) {
        if (flagTimeMode) {
          selectedTime = TimeOfDay.fromDateTime(newDateTime);
          _updateTimeFunction(selectedTime);
        } else {
          _updateDateFunction(newDateTime);
        }
      },
      use24hFormat: false,
      minuteInterval: 1,
      maximumDate: new DateTime(2050, 12, 30),
      minimumDate: DateTime.now().subtract(Duration(days: 1, hours: 1)),
      minimumYear: 2021,
      maximumYear: 2050,
    );
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context, initialDate: selectedDate, initialDatePickerMode: DatePickerMode.day, firstDate: DateTime(2015), lastDate: DateTime(2101));
    if (picked != null)
      setState(() {
        _updateDateFunction(picked);
      });
  }

  Future<Null> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null) _updateTimeFunction(picked);
  }

  void _updateDateFunction(DateTime newDateTime) {
    setState(() {
      selectedDate = newDateTime;
      _dateController.text = "${selectedDate.timeZoneName}, ${selectedDate.day} ${Utils.getMonth(selectedDate.month)} ${selectedDate.year}";
    });
  }

  void _updateTimeFunction(TimeOfDay selectedTime) {
    setState(() {
      _hour = selectedTime.hour.toString();
      _minute = selectedTime.minute.toString();
      _time = _hour! + ' : ' + _minute!;
      _timeController.text = _time!;
    });
  }

  bool isValidInput() {
    // ignore: unnecessary_null_comparison
    if (_dateController != null) {
      return _timeController.text.isNotEmpty && _dateController.text.isNotEmpty;
    } else
      return false;
  }
}
