import 'package:flutter/material.dart';
import 'package:reqres_user_app/app/core/constants/colors.dart';

ThemeData lightTheme = ThemeData(
  primaryColor: Colors.blue,
  brightness: Brightness.light,
  scaffoldBackgroundColor: grey900,
  // ✅ Define your color scheme
  colorScheme: const ColorScheme.light(
    primary: Colors.blue,           // main brand color
    secondary: Colors.orange,       // accent color
    background: grey900,
    surface: Colors.white,
    onPrimary: Colors.white,
    onSecondary: Colors.white,
    onBackground: Colors.white,
    onSurface: Colors.black,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: grey950,
    foregroundColor: Colors.white,
    elevation: 0,
  ),
  useMaterial3: true,
);