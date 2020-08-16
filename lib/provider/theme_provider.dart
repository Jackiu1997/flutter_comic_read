import 'package:comic_read/ui/helper/color_helper.dart';
import 'package:flutter/material.dart';

final ThemeData lightTheme = ThemeData(
  // Define the default brightness and colors.
  brightness: Brightness.light,
  primaryColor: Colors.black,
  accentColor: Colors.cyan[600],
  backgroundColor: Colors.grey[100],
  bottomAppBarColor: yellowC1,
  hintColor: Colors.grey,
  disabledColor: greyC1,

  // Define the default font family.
  fontFamily: 'NotoSans',

  // Define the default TextTheme. Use this to specify the default
  // text styling for headlines, titles, bodies of text, and more.
  textTheme: TextTheme(
    headline1: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold),
    headline2: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
    headline3: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold),
    headline6: TextStyle(fontSize: 26.0, fontStyle: FontStyle.italic),
    subtitle1: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    subtitle2: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
    bodyText1: TextStyle(fontSize: 16.0),
    bodyText2: TextStyle(fontSize: 14.0),
  ),
  primaryTextTheme: TextTheme(
    headline1: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold, color: greyC1),
    headline6: TextStyle(fontSize: 26.0, fontStyle: FontStyle.italic, color: greyC1),
    subtitle1: TextStyle(fontSize: 24, color: greyC1),
    subtitle2: TextStyle(fontSize: 22, color: greyC1),
    bodyText1: TextStyle(fontSize: 16.0, color: greyC1),
    bodyText2: TextStyle(fontSize: 14.0, color: greyC1),
  ),
);
