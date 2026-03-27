import 'package:flutter/material.dart';

abstract class AppColors {
  static const background = Color(0xFF0A0A0A);
  static const surface = Color(0xFF141414);
  static const surfaceVariant = Color(0xFF1E1E1E);
  static const accent = Color(0xFFE53935);
  static const accentDim = Color(0xFFB71C1C);
  static const white = Colors.white;
  static final textSecondary = Colors.white.withOpacity(0.5);
  static final textTertiary = Colors.white.withOpacity(0.3);
  static final borderAccent = const Color(0xFFE53935).withOpacity(0.15);
  static final borderSubtle = Colors.white.withOpacity(0.08);
}

abstract class AppRadius {
  static const sm = 14.0;
  static const md = 24.0;
}

abstract class AppTextStyles {
  static const heading = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: AppColors.white,
    letterSpacing: -0.5,
  );

  static const headingLarge = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: AppColors.white,
    letterSpacing: -0.5,
  );

  static const title = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.white,
  );

  static const body = TextStyle(
    fontSize: 15,
    color: AppColors.white,
  );

  static final bodySecondary = TextStyle(
    fontSize: 15,
    color: AppColors.textSecondary,
  );

  static const label = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w600,
    color: AppColors.white,
    letterSpacing: 0.5,
  );

  static final labelSecondary = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondary,
  );

  static const button = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.white,
    letterSpacing: 0.5,
  );

  static const caption = TextStyle(
    fontSize: 11,
    color: AppColors.white,
  );

  static final captionSecondary = TextStyle(
    fontSize: 11,
    color: AppColors.textSecondary,
  );

  static final navLabel = TextStyle(
    fontSize: 11,
    color: AppColors.textTertiary,
  );

  static const navLabelActive = TextStyle(
    fontSize: 11,
    color: AppColors.accent,
    fontWeight: FontWeight.w500,
  );
}

class AppTheme {
  static ThemeData get dark => ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: AppColors.background,
        colorScheme: const ColorScheme.dark(
          primary: AppColors.accent,
          surface: AppColors.surface,
          onPrimary: AppColors.white,
          onSurface: AppColors.white,
        ),
        useMaterial3: true,
        fontFamily: 'Inter',
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.background,
          elevation: 0,
          surfaceTintColor: Colors.transparent,
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: AppColors.surface,
          selectedItemColor: AppColors.accent,
          unselectedItemColor: AppColors.textTertiary,
        ),
      );
}
