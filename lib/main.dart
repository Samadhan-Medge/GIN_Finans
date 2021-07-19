import 'package:flutter/material.dart';
import 'package:gin_finans_app/src/values/theme.dart';

import 'src/ui/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    CustomThemeData customThemeData = CustomThemeData(context: context);
    return MaterialApp(
      title: 'GIN Finans',
      theme: customThemeData.themeData,
      home: HomeScreen(title: 'Flutter Demo Home Page'),
    );
  }
}


