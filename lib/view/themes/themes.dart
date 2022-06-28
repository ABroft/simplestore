import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  fontFamily: "Roboto",
  textTheme: ThemeData.light().textTheme.copyWith(
      
      titleLarge: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
      titleMedium: const TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),
      titleSmall: const TextStyle(fontSize: 14.0, fontWeight: FontWeight.normal),
      
  ),
  hoverColor: const Color(0xFFD8D8D8),
  shadowColor: const Color(0x40AAA6A6),
  scaffoldBackgroundColor: Colors.white,
  cardColor: const Color(0xFFF8F8F8),
  colorScheme: ThemeData.light().colorScheme.copyWith(
    primary: const Color(0xFF0B317A),
    onPrimary: Colors.white,
    surface: const Color(0xFFF6F6F6),
    
  ) 
);


ThemeData darkTheme = ThemeData.dark().copyWith(
  primaryColor: const  Color(0xFF0B317A),
);