import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:gin_finans_app/src/repositories/provider.dart';

import 'provider.dart';

class Repository {
  DataProvider? _model;

  Future<DataProvider> getDropDownDataModel() async {
    String string = await rootBundle.loadString('assets/data.json');
    Map<String, dynamic> values = json.decode(string);
    _model = DataProvider.fromJson(values);
    return _model!;
  }
}
