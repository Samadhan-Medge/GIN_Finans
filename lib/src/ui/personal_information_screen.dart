import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:gin_finans_app/src/listeners/sub_screen_callback_listener.dart';
import 'package:gin_finans_app/src/repositories/data_model.dart';
import 'package:gin_finans_app/src/repositories/monthly_expense_model.dart';
import 'package:gin_finans_app/src/ui/custom_ui/custom_dropdown.dart';
import 'package:gin_finans_app/src/values/dimensions.dart';

class PersonalInformationScreen extends StatefulWidget {
  final SubScreenCallbackListener subScreenCallbackListener;

  PersonalInformationScreen({required this.subScreenCallbackListener});

  @override
  _PersonalInformationScreenState createState() => _PersonalInformationScreenState();
}

class _PersonalInformationScreenState extends State<PersonalInformationScreen> {
  String? _selectedGoalItem;
  String? _selectedMonthlyIncomeRange;
  String? _selectedMonthlyExpense;

  DataModel? _model;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<DataModel>(
          future: getDropDownDataModel(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Scrollbar(
                child: Column(
                  children: [
                    Text("Personal Information", style: Theme.of(context).textTheme.bodyText1),
                    SizedBox(height: 10.0),
                    Text("Please fill in the information below and your goal for digital saving",
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: AppDimensions.textSizeSmall)),
                    CustomDropDown(
                      hint: 'Goal for activation',
                      dropdownMenuItems: buildDropDownMenuItems(snapshot.data!.goalOfActivation),
                      selectedItem: _selectedGoalItem!,
                      callBack: (selectedValue) {
                        setState(() {
                          _selectedGoalItem = selectedValue;
                        });
                      },
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    CustomDropDown(
                      hint: 'Monthly Income',
                      dropdownMenuItems: buildDropDownMenuItems(snapshot.data!.monthlyIncome),
                      selectedItem: _selectedMonthlyIncomeRange!,
                      callBack: (selectedValue) {
                        setState(() {
                          _selectedMonthlyIncomeRange = selectedValue;
                        });
                      },
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    CustomDropDown(
                      hint: 'Monthly Expense',
                      dropdownMenuItems: buildDropDownMenuItems(snapshot.data!.monthlyExpense),
                      selectedItem: _selectedMonthlyExpense!,
                      callBack: (selectedValue) {
                        setState(() {
                          _selectedMonthlyExpense = selectedValue;
                        });
                      },
                    ),
                  ],
                ),
              );
            } else {
              return Text('Error while loading data');
            }
          },
        ),
      ),
    );
  }
  List<DropdownMenuItem<String>> buildDropDownMenuItems(
      List<MonthlyExpenseModel> listItems) {
    List<DropdownMenuItem<String>> items = [];
    for (MonthlyExpenseModel listItem in listItems) {
      items.add(
        DropdownMenuItem(
          child: Text(listItem.name),
          value: listItem.name,
        ),
      );
    }
    return items;
  }

  bool isValidFields(){
    if(_selectedMonthlyExpense!=null && _selectedGoalItem!=null && _selectedMonthlyIncomeRange!=null){
      return _selectedMonthlyExpense!.isNotEmpty && _selectedGoalItem!.isNotEmpty &&  _selectedMonthlyIncomeRange!.isNotEmpty;
    }else
      return false;
  }

  Future<DataModel> getDropDownDataModel() async {
    String string = await rootBundle.loadString('assets/data.json');
    Map<String , dynamic > values = json.decode(string);
    _model = DataModel.fromJson(values);
    return _model!;
  }
}