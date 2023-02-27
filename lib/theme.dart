// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final xwhite = Colors.white;
final xGreyLight = Colors.grey.shade200;
final xGrey = Colors.grey.shade300;
final xText = Colors.blueGrey;
final xgreyer = Colors.grey.shade700;
final xDarkGrey = Colors.grey.shade800;
final xtrans = Colors.transparent;

final TextTheme xTextTheme = TextTheme(
  displayLarge: GoogleFonts.bebasNeue(fontSize: 25, color: xText),
  displayMedium: GoogleFonts.bebasNeue(fontSize: 25, color: xText),
  displaySmall: GoogleFonts.bebasNeue(fontSize: 20, color: xText),
  headlineLarge: GoogleFonts.poppins(fontSize: 20, color: xText),
  headlineMedium: GoogleFonts.poppins(fontSize: 15, color: xgreyer),
  headlineSmall: GoogleFonts.poppins(fontSize: 12, color: xgreyer),
);

final ThemeData customTheme = ThemeData(
  primaryColor: xGrey,
  scaffoldBackgroundColor: xGrey,
  primarySwatch: Colors.blueGrey,
  textTheme: xTextTheme,
  colorScheme: ColorScheme.fromSwatch().copyWith(secondary: xText),
);
