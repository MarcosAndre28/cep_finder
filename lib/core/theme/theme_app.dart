import 'package:cep_finder/core/res/colours.dart';
import 'package:cep_finder/core/res/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

final ThemeData appTheme = ThemeData(
  appBarTheme: const AppBarTheme(
    color: Colors.white,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.black,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  ),
  scaffoldBackgroundColor: Colors.white,
  fontFamily: Fonts.roboto,
  highlightColor: Colors.transparent,
  splashColor: Colors.transparent,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Colours.white,
    elevation: 10,
    enableFeedback: false,
    selectedItemColor: Colours.tealBlue,
    unselectedItemColor: Colours.grey,
    type: BottomNavigationBarType.fixed,
    landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
    showSelectedLabels: true,
    showUnselectedLabels: true,
    selectedLabelStyle: TextStyle(
      fontFamily: Fonts.roboto,
      fontWeight: FontWeight.w600,
      fontSize: 16,
    ),
    unselectedLabelStyle: TextStyle(
      fontFamily: Fonts.roboto,
      fontWeight: FontWeight.w600,
      fontSize: 16,
    ),
  ),
);
