import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final theme = ThemeData(
  textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme),
  colorScheme: const ColorScheme.dark(
    primary: Color(0xff0D7650),
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
);
