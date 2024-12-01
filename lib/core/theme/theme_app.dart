import 'package:cep_finder/core/res/colours.dart';
import 'package:cep_finder/core/res/fonts.dart';
import 'package:flutter/material.dart';

final ThemeData appTheme = ThemeData(
  fontFamily: Fonts.roboto,
  highlightColor: Colors.transparent,
  splashColor: Colors.transparent,
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Colours.white,
    elevation: 0,
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
