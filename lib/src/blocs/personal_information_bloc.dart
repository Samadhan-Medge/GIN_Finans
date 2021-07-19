import 'package:gin_finans_app/src/repositories/provider.dart';
import 'package:gin_finans_app/src/repositories/repository.dart';
import 'package:rxdart/rxdart.dart';

class PersonalInformationBloc {
  String? selectedGoalItem;
  String? selectedMonthlyIncomeRange;
  String? selectedMonthlyExpense;

  final _repository = Repository();
  final _moviesFetcher = PublishSubject<DataProvider>();

  Stream<DataProvider> get allMovies => _moviesFetcher.stream;

  fetchAllMovies() async {
    DataProvider itemModel = await _repository.getDropDownDataModel();
    _moviesFetcher.sink.add(itemModel);
  }

  dispose() {
    _moviesFetcher.close();
  }

  bool isValidFields() {
    if (selectedMonthlyExpense != null && selectedGoalItem != null && selectedMonthlyIncomeRange != null) {
      return selectedMonthlyExpense!.isNotEmpty && selectedGoalItem!.isNotEmpty && selectedMonthlyIncomeRange!.isNotEmpty;
    } else
      return false;
  }


}

final bloc = PersonalInformationBloc();
