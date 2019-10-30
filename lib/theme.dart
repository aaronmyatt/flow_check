import 'package:flutter/material.dart';

const PRIMARY_COLOUR = Color(0xFF0477BF);
const SECONDARY_COLOUR = Color(0xFF04B2D9);
const ACCENT1_COLOUR = Color(0xFF048ABF);
const ACCENT2_COLOUR = Color(0xFF04C4D9);
const ACCENT3_COLOUR = Color(0xFFF2F1F0);

ColorScheme flowCheckColorScheme = ColorScheme(
  primary: PRIMARY_COLOUR,
  secondary: SECONDARY_COLOUR,
  background: SECONDARY_COLOUR,
  primaryVariant: ACCENT1_COLOUR,
  secondaryVariant: ACCENT2_COLOUR,
  surface: SECONDARY_COLOUR,
  error: Colors.red,
  onError: Colors.red,
  onPrimary: Colors.white,
  onSecondary: Colors.white,
  onBackground: Colors.black,
  onSurface: Colors.black,
  brightness: Brightness.light,
);

ThemeData flowCheckTheme = ThemeData(
  primaryColor: PRIMARY_COLOUR,
  colorScheme: flowCheckColorScheme,
  accentColor: ACCENT3_COLOUR,
  textTheme: flowCheckTextTheme,
  iconTheme: flowCheckIconTheme,
  backgroundColor: SECONDARY_COLOUR,
  scaffoldBackgroundColor: SECONDARY_COLOUR,
  cursorColor: ACCENT3_COLOUR,
  inputDecorationTheme: InputDecorationTheme(
    prefixStyle: TextStyle(color: ACCENT3_COLOUR),
    hintStyle: TextStyle(color: ACCENT3_COLOUR),
    fillColor: ACCENT2_COLOUR,
    filled: true,
  ),
  appBarTheme: AppBarTheme(
    iconTheme: flowCheckIconTheme,
    textTheme: flowCheckTextTheme,
    color: PRIMARY_COLOUR,
  ),
);

TextTheme flowCheckTextTheme = TextTheme(
  title: TextStyle(
      color: ACCENT3_COLOUR, fontWeight: FontWeight.w600, fontSize: 24.0),
  body1: TextStyle(color: ACCENT3_COLOUR),
  body2: TextStyle(color: ACCENT3_COLOUR),
  display1: TextStyle(color: ACCENT3_COLOUR),
  subhead: TextStyle(color: ACCENT3_COLOUR),
);

IconThemeData flowCheckIconTheme = IconThemeData(
  color: ACCENT3_COLOUR,
  opacity: 1.0,
);
