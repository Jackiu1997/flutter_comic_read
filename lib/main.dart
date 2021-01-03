import 'package:comic_read/provider/settings_provider.dart';
import 'package:comic_read/provider/theme_provider.dart';
import 'package:comic_read/ui/page/tab_navigator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Comic Read',
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => SettingsProvider()),
        ],
        child: TabNavigator(),
      ),
      theme: lightTheme,
    );
  }
}
