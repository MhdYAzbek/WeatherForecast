import 'package:flutter/material.dart';

ThemeData theme() {
  return ThemeData(
    textTheme: textTheme(),
    primarySwatch: Colors.blue,
  );
}

textTheme() {
  return TextTheme(
    bodyText1: TextStyle(color: Colors.white),
    bodyText2: TextStyle(color: Colors.white.withOpacity(0.8)),
  );
}
