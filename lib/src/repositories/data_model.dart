
import 'monthly_expense_model.dart';

class DataModel{

  List<MonthlyExpenseModel> goalOfActivation;
  List<MonthlyExpenseModel> monthlyIncome;
  List<MonthlyExpenseModel> monthlyExpense;

  DataModel({required this.goalOfActivation , required this.monthlyIncome , required this.monthlyExpense});

  factory DataModel.fromJson(Map<String , dynamic> json){
    var goalList  = json['Goal of Activation'] as List;
    List<MonthlyExpenseModel> gList =  goalList.map((e) => MonthlyExpenseModel.fromJson(e)).toList();
    var monthlyIncomeList  = json['Monthly Income'] as List;
    List<MonthlyExpenseModel> mIncomeList =  monthlyIncomeList.map((e) => MonthlyExpenseModel.fromJson(e)).toList();
    var monthlyExpenseList  = json['Monthly Expense'] as List;
    List<MonthlyExpenseModel> mExpenseList =  monthlyExpenseList.map((e) => MonthlyExpenseModel.fromJson(e)).toList();
    return DataModel(
      goalOfActivation: gList,
      monthlyIncome: mIncomeList,
      monthlyExpense: mExpenseList
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "goalOfActivation": this.goalOfActivation,
      "monthlyIncome": this.monthlyIncome,
      "monthlyExpense": this.monthlyExpense,
    };
  }

}