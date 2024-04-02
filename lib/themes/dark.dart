import 'package:flutter/material.dart';

final ThemeData darkThemeData = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  primaryColor: Colors.grey[900],
  canvasColor: Colors.grey[800],
  buttonTheme: const ButtonThemeData(
    colorScheme: ColorScheme.dark(), // This will affect contained buttons color
    textTheme: ButtonTextTheme
        .primary, // This will affect outline and text buttons color
  ),
  scaffoldBackgroundColor: Colors.grey[900],
  textTheme: const TextTheme(
    displayLarge: TextStyle(color: Colors.white),
    displayMedium: TextStyle(color: Colors.white),
    displaySmall: TextStyle(color: Colors.white),
    headlineMedium: TextStyle(color: Colors.white),
    headlineSmall: TextStyle(color: Colors.white),
    titleLarge: TextStyle(color: Colors.white),
    titleMedium: TextStyle(color: Colors.white70),
    titleSmall: TextStyle(color: Colors.white70),
    bodyLarge: TextStyle(color: Colors.white60),
    bodyMedium: TextStyle(color: Colors.white60),
  ),
  colorScheme: ColorScheme.fromSwatch(brightness: Brightness.dark)
      .copyWith(secondary: Colors.grey[500]),
);
