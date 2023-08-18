import 'package:flutter/material.dart';

class ThemeClass {
  Color lightPrimaryColor = Color(0xFF836096);
  Color lightSecondaryColor = Color(0xFFF0B86E);
  Color lightBackgroundColor = Color(0xFFFFFFFF);
  Color lightCardButtonColor = Color(0xFFED7B7B);

  Color darkPrimaryColor = Color(0xFF222831);
  Color darkSecondaryColor = Color(0xFFFFFFFF);
  Color darkBackgroundColor = Color(0xFF393E46);
  Color darkCardButtonColor = Color(0xFFeb5e28);

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    primaryColor: _themeClass.lightPrimaryColor,
    scaffoldBackgroundColor: _themeClass.lightBackgroundColor,
    cardColor: _themeClass.lightSecondaryColor,
    appBarTheme: AppBarTheme(
      color: _themeClass.lightPrimaryColor,
      shadowColor: _themeClass.lightPrimaryColor,
    ),
    colorScheme: const ColorScheme.light().copyWith(
      primary: _themeClass.lightPrimaryColor,
      secondary: _themeClass.lightSecondaryColor,
    ),
    textTheme: TextTheme(
      titleMedium:
          TextStyle(color: _themeClass.lightBackgroundColor, fontSize: 18),
      titleLarge: TextStyle(color: _themeClass.lightBackgroundColor),
      titleSmall:
          TextStyle(color: _themeClass.lightBackgroundColor, fontSize: 15),
      bodyLarge:
          TextStyle(color: _themeClass.lightBackgroundColor, fontSize: 23),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: _themeClass.lightPrimaryColor,
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: _themeClass.lightCardButtonColor,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    primaryColor: _themeClass.darkPrimaryColor,
    cardColor: _themeClass.darkSecondaryColor,
    scaffoldBackgroundColor: _themeClass.darkBackgroundColor,
    appBarTheme: AppBarTheme(
      color: _themeClass.darkPrimaryColor,
      shadowColor: _themeClass.darkPrimaryColor,
    ),
    colorScheme: const ColorScheme.dark().copyWith(
      primary: _themeClass.darkPrimaryColor,
      secondary: _themeClass.darkSecondaryColor,
    ),
    textTheme: TextTheme(
      titleMedium:
          TextStyle(color: _themeClass.darkBackgroundColor, fontSize: 18),
      titleLarge: TextStyle(color: _themeClass.darkSecondaryColor),
      titleSmall:
          TextStyle(color: _themeClass.darkSecondaryColor, fontSize: 15),
      bodyLarge:
          TextStyle(color: _themeClass.darkBackgroundColor, fontSize: 23),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: _themeClass.darkPrimaryColor,
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: _themeClass.darkCardButtonColor,
    ),
  );
}

ThemeClass _themeClass = ThemeClass();
