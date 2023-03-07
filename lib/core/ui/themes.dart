import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData.light(
  useMaterial3: true,
).copyWith(
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color.fromARGB(255, 7, 41, 70),
  ),
);
ThemeData darkTheme = ThemeData.dark();
