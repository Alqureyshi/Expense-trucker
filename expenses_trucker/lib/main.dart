import 'package:expenses_trucker/pages/expenses.dart';
import 'package:flutter/material.dart';

var kColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 96, 59, 181),
);
void main() {
  runApp(MaterialApp(
    theme: ThemeData().copyWith(
      colorScheme: kColorScheme,
      // appBarTheme: AppBarTheme().copyWith(
      //     backgroundColor: kColorScheme.primaryContainer,
      //     foregroundColor: kColorScheme.primaryContainer),
      cardTheme: CardTheme(
        color: kColorScheme.secondaryContainer,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            backgroundColor: kColorScheme.primaryContainer),
      ),
    ),
    debugShowCheckedModeBanner: false,
    home: const Expenses(),
  ));
}
