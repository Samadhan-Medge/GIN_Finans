import 'package:flutter/material.dart';
import 'package:gin_finans_app/src/blocs/personal_information_bloc.dart';
import 'package:gin_finans_app/src/listeners/sub_screen_callback_listener.dart';
import 'package:gin_finans_app/src/repositories/monthly_expense_model.dart';
import 'package:gin_finans_app/src/repositories/provider.dart';
import 'package:gin_finans_app/src/ui/custom_ui/custom_dropdown.dart';
import 'package:gin_finans_app/src/values/dimensions.dart';

import 'custom_ui/next_button.dart';

class PersonalInformationScreen extends StatefulWidget {
  final SubScreenCallbackListener subScreenCallbackListener;

  PersonalInformationScreen({required this.subScreenCallbackListener});

  @override
  _PersonalInformationScreenState createState() => _PersonalInformationScreenState();
}

class _PersonalInformationScreenState extends State<PersonalInformationScreen> {
  @override
  void initState() {
    super.initState();
    bloc.fetchAllMovies();
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DataProvider>(
      stream: bloc.allMovies,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(AppDimensions.fieldSpacing),
                    child: MediaQuery.removePadding(
                      context: context,
                      removeTop: true,
                      child: ListView(
                        shrinkWrap: false,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Personal Information", style: Theme.of(context).textTheme.bodyText1),
                              SizedBox(height: 10.0),
                              Text("Please fill in the information below and your goal for digital saving",
                                  style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: AppDimensions.textSizeSmall)),
                              SizedBox(height: 20.0),
                              CustomDropDown(
                                hint: 'Goal for activation',
                                dropdownMenuItems: buildDropDownMenuItems(snapshot.data!.goalOfActivation),
                                selectedItem: bloc.selectedGoalItem ?? null,
                                callBack: (selectedValue) {
                                  setState(() {
                                    bloc.selectedGoalItem = selectedValue;
                                  });
                                },
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              CustomDropDown(
                                hint: 'Monthly Income',
                                dropdownMenuItems: buildDropDownMenuItems(snapshot.data!.monthlyIncome),
                                selectedItem: bloc.selectedMonthlyIncomeRange ?? null,
                                callBack: (selectedValue) {
                                  setState(() {
                                    bloc.selectedMonthlyIncomeRange = selectedValue;
                                  });
                                },
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              CustomDropDown(
                                hint: 'Monthly Expense',
                                dropdownMenuItems: buildDropDownMenuItems(snapshot.data!.monthlyExpense),
                                selectedItem: bloc.selectedMonthlyExpense ?? null,
                                callBack: (selectedValue) {
                                  setState(() {
                                    bloc.selectedMonthlyExpense = selectedValue;
                                  });
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
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
        } else if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        } else {
          return Text('Error while loading data');
        }
      },
    );
  }

  List<DropdownMenuItem<String>> buildDropDownMenuItems(List<MonthlyExpenseModel> listItems) {
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
}
