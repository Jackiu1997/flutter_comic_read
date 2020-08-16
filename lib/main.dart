import 'package:comic_read/provider/theme_provider.dart';
import 'package:comic_read/ui/page/tab_navigator.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: TabNavigator(),
      theme: lightTheme,
    );
  }
}
