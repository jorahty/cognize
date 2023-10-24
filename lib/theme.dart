import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final theme = ThemeData(
  cardTheme: CardTheme(
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15.0),
    ),
    clipBehavior: Clip.antiAlias,
    color: const Color(0xff415575),
  ),
  appBarTheme: const AppBarTheme(elevation: 0),
  scaffoldBackgroundColor: const Color(0xff192E50),
  textTheme: TextTheme(
    bodyMedium: GoogleFonts.inter(
      fontSize: 14,
      fontWeight: FontWeight.w500,
    ),
    bodyLarge: GoogleFonts.inter(
      fontSize: 16,
      fontWeight: FontWeight.w500,
    ),
    titleMedium: GoogleFonts.inter(
      fontSize: 18,
      fontWeight: FontWeight.w500,
    ),
    titleLarge: GoogleFonts.inter(
      fontSize: 18,
      fontWeight: FontWeight.w700,
    ),
    headlineSmall: GoogleFonts.inter(
      fontSize: 24,
      fontWeight: FontWeight.w700,
    ),
    labelLarge: GoogleFonts.inter(
      fontSize: 14,
      fontWeight: FontWeight.w700,
      color: Colors.white60,
    ),
    labelMedium: GoogleFonts.inter(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: Colors.white60,
    ),
    headlineMedium: GoogleFonts.inter(
      fontSize: 36,
      fontWeight: FontWeight.w700,
      color: Colors.white,
    ),
    displayMedium: GoogleFonts.inter(
      fontSize: 48,
      fontWeight: FontWeight.w700,
      color: Colors.white,
    ),
  ),
  colorScheme: const ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xff2A66FF),
    onPrimary: Colors.white,
    secondary: Color(0xff17B24C),
    onSecondary: Colors.white,
    error: Colors.red,
    onError: Colors.white,
    background: Color(0xff192E50),
    onBackground: Colors.white,
    surface: Color(0xff415575),
    onSurface: Colors.white,
    surfaceVariant: Color(0xff0D1B3E),
  ),
);

// final theme = ThemeData(
//   splashFactory: NoSplash.splashFactory,
//   textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme),
//   colorScheme: const ColorScheme.dark(
//     primary: Color(0xff0D7650),
//     onPrimary: Colors.white,
//     shadow: Colors.transparent,
//   ),
//   appBarTheme: AppBarTheme(
//     backgroundColor: const Color(0xff0D7650),
//     centerTitle: false,
//     elevation: 0,
//     titleTextStyle: GoogleFonts.inter(
//       fontSize: 18,
//       fontWeight: FontWeight.bold,
//       color: Colors.white,
//     ),
//   ),
//   bottomNavigationBarTheme: BottomNavigationBarThemeData(
//     backgroundColor: Colors.black45,
//     selectedItemColor: Colors.green,
//     selectedLabelStyle: GoogleFonts.inter(
//       fontSize: 12,
//       height: 1.7,
//       fontWeight: FontWeight.bold,
//       color: Colors.white,
//     ),
//     unselectedLabelStyle: GoogleFonts.inter(
//       fontSize: 12,
//       height: 1.7,
//       fontWeight: FontWeight.bold,
//       color: Colors.white,
//     ),
//   ),
//   navigationRailTheme: NavigationRailThemeData(
//     backgroundColor: Colors.black45,
//     selectedIconTheme: const IconThemeData(color: Colors.green),
//     selectedLabelTextStyle: GoogleFonts.inter(
//       fontSize: 12,
//       height: 1.8,
//       fontWeight: FontWeight.bold,
//       color: Colors.green,
//     ),
//     unselectedLabelTextStyle: GoogleFonts.inter(
//       fontSize: 12,
//       height: 1.8,
//       fontWeight: FontWeight.bold,
//       color: Colors.grey[400],
//     ),
//   ),
//   filledButtonTheme: FilledButtonThemeData(
//     style: FilledButton.styleFrom(
//       padding: const EdgeInsets.all(20),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(12.0),
//       ),
//     ),
//   ),
// );
