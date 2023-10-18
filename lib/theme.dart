import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final theme = ThemeData(
  fontFamily: GoogleFonts.inter().fontFamily,
  appBarTheme: AppBarTheme(
    backgroundColor: const Color(0xff0D7650),
    centerTitle: false,
    elevation: 0,
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontFamily: GoogleFonts.inter().fontFamily,
      fontSize: 18,
    ),
  ),
  colorScheme: const ColorScheme.dark(
    primary: Color(0xff0D7650),
    shadow: Colors.transparent,
  ),
);
