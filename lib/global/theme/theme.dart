import 'package:flutter/material.dart';

const appPrimaryColor = Color(0xFF0E1C36);
const blueTextColor = Color(0xFF1A6FEE);

///big title color
const titleBlackColor = Color(0xFF020202);
const descriptionGreyColor = Color(0xFF8A929B);
const labelBlackColor = Color(0xFF000000);
const successColor = Color(0xFF4CAF50);

const borderColor = Color(0xFFD7D7D7);
//Color(0xFF6FCF97);

///login inputColors
const geryHintLoginInputColor = Color(0xFFA4AFAF);
const geryInputLoginBorderColor = Color(0xFFDDDDDD);
const geryInputLoginBackGroundColor = Color(0xFFF4F8FA);
const geryInputLoginInnerShadowColor = Color(0xFFE2E7EB);
const geryTextLoginInputColor = Color(0xFF111827);
const redErrorLoginInputColor = Color(0xFFEF1A1F);

const buttonDarkTextColor = Color(0xFF1F2937);
const checkBoxTextColor = Color(0xFF9CA3AF);

const blackAppBarTextColor = Color(0xFF212225);

const globalBackgroundColor = Color(0xFFFFFFFF);

const bottomNavigationBarBorderColor = Color(0xFFEEECEC);

const bottomNavigationBarTitleColor = Color(0xFF718093);

const homeAppBarBorderColor = Color(0xFFE0E0E0);

const descriptionTextColor = Color(0xFF596372);

final ThemeData appGlobalTheme = ThemeData(
  useMaterial3: true,
  primaryColor: appPrimaryColor,
  fontFamily: 'Poppins',
  appBarTheme: const AppBarTheme(backgroundColor: Colors.white),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(),
  textTheme: const TextTheme(
    titleLarge: TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.w500,
    ),
    displayLarge: TextStyle(
      fontSize: 20,
      color: titleBlackColor,
      fontWeight: FontWeight.w700,
      height: 1.58,
      // Calculated by dividing line height (37.16) by font size (20)
    ),
    displayMedium: TextStyle(
      color: blackAppBarTextColor,
      fontSize: 18,
      height: 1.057,
      fontWeight: FontWeight.w600,
    ),
    displaySmall: TextStyle(
      color: labelBlackColor,
      fontSize: 14,
      height: 1.28,
      fontWeight: FontWeight.w500,
    ),
    headlineMedium: TextStyle(
      fontSize: 13,
      color: buttonDarkTextColor,
      fontWeight: FontWeight.w400,
      height: 1.4615,
      // calculated as 19px / 13px
      letterSpacing: 0.13, // calculated as 1% of 13px
    ),
    headlineSmall: TextStyle(
      fontSize: 12,
      color: geryTextLoginInputColor,
      height: 1.583,
      fontWeight: FontWeight.w400,
    ),
    titleMedium: TextStyle(
      fontSize: 14,
      color: descriptionGreyColor,
      height: 1.43,
      letterSpacing: 0.17,
      fontWeight: FontWeight.w400,
    ),
    titleSmall: TextStyle(
      fontSize: 11,
      color: Colors.black,
      height: 1.65,
      fontWeight: FontWeight.w400,
    ),
    bodyLarge: TextStyle(
      fontSize: 13.71,
      color: descriptionTextColor,
      height: 1.19,
      fontWeight: FontWeight.w600,
    ),
    bodyMedium: TextStyle(
      fontSize: 12,
      height: 1.19,
      color: Colors.black,
      fontWeight: FontWeight.w400,
    ),
    labelMedium: TextStyle(
      fontSize: 16,
      height: 1.46,
      color: labelBlackColor,
      fontWeight: FontWeight.w400,
    ),
  ),
);
