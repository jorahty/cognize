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
    selectedItemColor: const Color(0xff00CD77),
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
    backgroundColor: const Color(0xFF181818),
    selectedIconTheme: const IconThemeData(color: Color(0xff00CD77)),
    selectedLabelTextStyle: GoogleFonts.inter(
      fontSize: 12,
      height: 1.8,
      fontWeight: FontWeight.bold,
      color: const Color(0xff00CD77),
    ),
    unselectedLabelTextStyle: GoogleFonts.inter(
      fontSize: 12,
      height: 1.8,
      fontWeight: FontWeight.bold,
      color: Colors.grey[400],
    ),
  ),
);
