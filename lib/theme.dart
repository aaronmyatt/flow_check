import 'package:flutter/material.dart';

const PRIMARY_COLOUR = Colors.white;
const SECONDARY_COLOUR = Colors.black54;
const ACCENT1_COLOUR = Colors.black12;
const ACCENT2_COLOUR = Colors.grey;

ColorScheme flowCheckColorScheme = ColorScheme(
  primary: PRIMARY_COLOUR,
  secondary: SECONDARY_COLOUR,
  background: SECONDARY_COLOUR,
  primaryVariant: ACCENT1_COLOUR,
  secondaryVariant: ACCENT2_COLOUR,
  surface: SECONDARY_COLOUR,
  error: Colors.redAccent,
  onError: SECONDARY_COLOUR,
  onPrimary: SECONDARY_COLOUR,
  onSecondary: PRIMARY_COLOUR,
  onBackground: PRIMARY_COLOUR,
  onSurface: PRIMARY_COLOUR,
  brightness: Brightness.light,
);

ThemeData flowCheckTheme = ThemeData(
  primaryColor: PRIMARY_COLOUR,
  accentColor: ACCENT1_COLOUR,
  textTheme: flowCheckTextTheme,
  iconTheme: flowCheckIconTheme,
  inputDecorationTheme: InputDecorationTheme(
    prefixStyle: TextStyle(color: SECONDARY_COLOUR),
    hintStyle: TextStyle(color: SECONDARY_COLOUR),
  ),
  appBarTheme: AppBarTheme(
    iconTheme: flowCheckIconTheme,
    textTheme: flowCheckTextTheme,
  ),
  backgroundColor: ACCENT2_COLOUR,
);

TextTheme flowCheckTextTheme = TextTheme(
  title: TextStyle(
      color: SECONDARY_COLOUR, fontWeight: FontWeight.w600, fontSize: 24.0),
  body1: TextStyle(color: SECONDARY_COLOUR),
  body2: TextStyle(color: SECONDARY_COLOUR),
  display1: TextStyle(color: SECONDARY_COLOUR),
  subhead: TextStyle(color: SECONDARY_COLOUR),
);

IconThemeData flowCheckIconTheme = IconThemeData(
  color: SECONDARY_COLOUR,
  opacity: 1.0,
);
