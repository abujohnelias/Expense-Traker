import 'package:expense_tracker/expenses.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

var kColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 200, 200, 200),
);
var kDarkColorScheme = ColorScheme.fromSeed(
  seedColor: Colors.cyan,
);
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: ThemeData.dark().copyWith(
        brightness: Brightness.dark,
        colorScheme: kDarkColorScheme,
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: kDarkColorScheme.secondary,
          foregroundColor: kDarkColorScheme.onPrimary,
          elevation: 0,
          scrolledUnderElevation: 0,
          
        ),
         floatingActionButtonTheme:
            const FloatingActionButtonThemeData().copyWith(
          backgroundColor: kDarkColorScheme.secondary,
          foregroundColor: kDarkColorScheme.onPrimary,
        ),
        bottomSheetTheme: const BottomSheetThemeData().copyWith(
          backgroundColor: kDarkColorScheme.secondary,
        ),
        textTheme: ThemeData().textTheme.copyWith(
              titleLarge: GoogleFonts.raleway(
                fontSize: 30,
                color: kDarkColorScheme.onPrimary,
                fontWeight: FontWeight.w400,
              ),
            ),
      ),
      theme: ThemeData().copyWith(
        canvasColor: kColorScheme.onPrimary,
        colorScheme: kColorScheme,
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: kColorScheme.secondary,
          foregroundColor: kColorScheme.onPrimary,
          elevation: 0,
          scrolledUnderElevation: 0,
        ),
        floatingActionButtonTheme:
            const FloatingActionButtonThemeData().copyWith(
          backgroundColor: kColorScheme.secondary,
          foregroundColor: kColorScheme.onPrimary,
        ),
        bottomSheetTheme: const BottomSheetThemeData().copyWith(
          backgroundColor: kColorScheme.onPrimary,
        ),
        textTheme: ThemeData().textTheme.copyWith(
              titleLarge: GoogleFonts.raleway(
                fontSize: 30,
                color: kColorScheme.onPrimary,
                fontWeight: FontWeight.w400,
              ),
            ),
      ),
      home: const Expenses(),
    );
  }
}
