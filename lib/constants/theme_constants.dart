import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,

    scaffoldBackgroundColor: const Color(0xFFF9FAFB),

    colorScheme: const ColorScheme(
      brightness: Brightness.light,

      primary: Color(0xFF4F46E5),
      onPrimary: Colors.white,

      secondary: Color(0xFF4F46E5),
      onSecondary: Colors.white,

      error: Colors.red,
      onError: Colors.white,

      background: Color(0xFFF9FAFB),
      onBackground: Color(0xFF111827),

      surface: Color(0xFFFFFFFF),
      onSurface: Color(0xFF111827),

      surfaceVariant: Color(0xFFF3F4F6),
      onSurfaceVariant: Color(0xFF6B7280),
    ),

    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFFF9FAFB),
      elevation: 0,
      scrolledUnderElevation: 0,
      surfaceTintColor: Colors.transparent,
      centerTitle: true,
      titleTextStyle: TextStyle(
        color: Color(0xFF111827),
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      iconTheme: IconThemeData(color: Color(0xFF111827)),
    ),


    textTheme: const TextTheme(
      bodyLarge: TextStyle(
        color: Color(0xFF111827),

      ),
      bodyMedium: TextStyle(
        color: Color(0xFF6B7280),

      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,

    scaffoldBackgroundColor: const Color(0xFF101827),

    colorScheme: const ColorScheme(
      brightness: Brightness.dark,

      primary: Color(0xFF4F46E5),
      onPrimary: Colors.white,

      secondary: Color(0xFF4F46E5),
      onSecondary: Colors.white,

      error: Colors.red,
      onError: Colors.white,

      background: Color(0xFF101827),
      onBackground: Color(0xFFF9FAFB),

      surface: Color(0xFF1F2937),
      onSurface: Color(0xFFF9FAFB),

      surfaceVariant: Color(0xFF374151),
      onSurfaceVariant: Color(0xFF9CA3AF),
    ),

    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF101827),
      elevation: 0,
      titleTextStyle: TextStyle(
        color: Color(0xFFF9FAFB),
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      iconTheme: IconThemeData(color: Color(0xFFF9FAFB)),
    ),
  );
}