import 'package:flutter/material.dart';

Color pinky = const Color(0XFFEED6D3);
ThemeData theme = ThemeData(
    primarySwatch: Colors.indigo,
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Color(0XFFA49393),),
    // scaffoldBackgroundColor: const Color(0XFFEED6D3),
    primaryColor: const Color(0XFFA49393),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0XFF67595E),
    ),
    bottomNavigationBarTheme:  const BottomNavigationBarThemeData(
       selectedItemColor:Color(0XFF67595E),
      unselectedItemColor: Colors.grey,

    ),
);
