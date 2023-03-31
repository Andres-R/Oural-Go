import 'package:flutter/material.dart';
import 'package:oural_go/utils/constants.dart';

ThemeData darkThemeData(BuildContext context) {
  return ThemeData(
    brightness: Brightness.dark,
    //color is also main bg color
    primaryColor: kDarkModeBG,
    colorScheme: ColorScheme(
      brightness: Brightness.dark,
      primary: Colors.transparent,
      onPrimary: Colors.transparent,
      secondary: Colors.transparent,
      onSecondary: Colors.transparent,
      error: Colors.transparent,
      onError: Colors.transparent,
      background: Colors.transparent,
      //
      onBackground: kDarkModeText,
      surface: kThemeColor,
      onSurface: kIconColor,
    ),
    //color is also main bg color
    appBarTheme: AppBarTheme(
      backgroundColor: kDarkModeBG,
      centerTitle: true,
      elevation: 0,
    ),
    //color is also main bg color
    scaffoldBackgroundColor: kDarkModeBG,
    textTheme: TextTheme(
      bodyMedium: TextStyle(
        color: kDarkModeText,
      ),
    ),
  );
}

ThemeData lightThemeData(BuildContext context) {
  return ThemeData(
    brightness: Brightness.light,
    //color is also main bg color
    primaryColor: kLightModeBG,
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: Colors.transparent,
      onPrimary: Colors.transparent,
      secondary: Colors.transparent,
      onSecondary: Colors.transparent,
      error: Colors.transparent,
      onError: Colors.transparent,
      background: Colors.transparent,
      //
      onBackground: kLightModeText,
      surface: kThemeColor,
      onSurface: kIconColor,
    ),
    //color is also main bg color
    appBarTheme: AppBarTheme(
      backgroundColor: kLightModeBG,
      centerTitle: true,
      elevation: 0,
    ),
    //color is also main bg color
    scaffoldBackgroundColor: kLightModeBG,
    textTheme: TextTheme(
      bodyMedium: TextStyle(
        color: kLightModeText,
      ),
    ),
  );
}
