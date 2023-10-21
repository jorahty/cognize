import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final theme = ThemeData(
  splashFactory: NoSplash.splashFactory,
  textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme),
  colorScheme: const ColorScheme.dark(
    primary: Color(0xff0D7650),
    onPrimary: Colors.white,
    shadow: Colors.transparent,
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: const Color(0xff0D7650),
    centerTitle: false,
    elevation: 0,
    titleTextStyle: GoogleFonts.inter(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Colors.black45,
    selectedItemColor: Colors.green,
    selectedLabelStyle: GoogleFonts.inter(
      fontSize: 12,
      height: 1.7,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    unselectedLabelStyle: GoogleFonts.inter(
      fontSize: 12,
      height: 1.7,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
  ),
  navigationRailTheme: NavigationRailThemeData(
    backgroundColor: Colors.black45,
    selectedIconTheme: const IconThemeData(color: Colors.green),
    selectedLabelTextStyle: GoogleFonts.inter(
      fontSize: 12,
      height: 1.8,
      fontWeight: FontWeight.bold,
      color: Colors.green,
    ),
    unselectedLabelTextStyle: GoogleFonts.inter(
      fontSize: 12,
      height: 1.8,
      fontWeight: FontWeight.bold,
      color: Colors.grey[400],
    ),
  ),
  filledButtonTheme: FilledButtonThemeData(
    style: FilledButton.styleFrom(
      padding: const EdgeInsets.all(20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
    ),
  ),
);
