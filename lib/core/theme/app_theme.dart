// lib/core/theme/app_theme.dart

import 'package:flutter/cupertino.dart';

class AppTheme {
  // ── Light palette ──────────────────────────────────────────────
  static const primaryBlue = Color(0xFF007AFF);
  static const secondaryBlue = Color(0xFF5AC8FA);
  static const backgroundLight = Color(0xFFF9F9F9);
  static const surfaceWhite = Color(0xFFFFFFFF);
  static const textPrimary = Color(0xFF1C1C1E);
  static const textSecondary = Color(0xFF8E8E93);
  static const dividerColor = Color(0xFFE5E5EA);
  static const successGreen = Color(0xFF34C759);
  static const warningOrange = Color(0xFFFF9500);
  static const errorRed = Color(0xFFFF3B30);

  // ── Dark palette ───────────────────────────────────────────────
  static const darkBackground = Color(0xFF000000);
  static const darkSurface = Color(0xFF1C1C1E);
  static const darkCard = Color(0xFF2C2C2E);
  static const darkDivider = Color(0xFF38383A);
  static const darkTextPrimary = Color(0xFFFFFFFF);
  static const darkTextSecondary = Color(0xFF8E8E93);

  // ── Theme builders ─────────────────────────────────────────────

  static CupertinoThemeData get cupertinoTheme => _buildTheme(Brightness.light);
  static CupertinoThemeData get cupertinoThemeDark => _buildTheme(Brightness.dark);

  static CupertinoThemeData _buildTheme(Brightness brightness) {
    final isDark = brightness == Brightness.dark;
    return CupertinoThemeData(
      primaryColor: primaryBlue,
      scaffoldBackgroundColor: isDark ? darkBackground : backgroundLight,
      barBackgroundColor: isDark ? darkSurface : surfaceWhite,
      brightness: brightness,
      textTheme: CupertinoTextThemeData(
        textStyle: TextStyle(
          fontFamily: 'SF Pro Display',
          fontSize: 17,
          color: isDark ? darkTextPrimary : textPrimary,
          letterSpacing: -0.41,
        ),
        navTitleTextStyle: TextStyle(
          fontFamily: 'SF Pro Display',
          fontSize: 17,
          fontWeight: FontWeight.w600,
          color: isDark ? darkTextPrimary : textPrimary,
          letterSpacing: -0.41,
        ),
        navLargeTitleTextStyle: TextStyle(
          fontFamily: 'SF Pro Display',
          fontSize: 34,
          fontWeight: FontWeight.w700,
          color: isDark ? darkTextPrimary : textPrimary,
          letterSpacing: 0.37,
        ),
      ),
    );
  }

  // Text Styles
  static const headline1 = TextStyle(
    fontFamily: 'SF Pro Display',
    fontSize: 34,
    fontWeight: FontWeight.w700,
    color: textPrimary,
    letterSpacing: 0.37,
    height: 1.2,
  );

  static const headline2 = TextStyle(
    fontFamily: 'SF Pro Display',
    fontSize: 28,
    fontWeight: FontWeight.w700,
    color: textPrimary,
    letterSpacing: 0.36,
    height: 1.2,
  );

  static const headline3 = TextStyle(
    fontFamily: 'SF Pro Display',
    fontSize: 22,
    fontWeight: FontWeight.w600,
    color: textPrimary,
    letterSpacing: 0.35,
    height: 1.3,
  );

  static const body1 = TextStyle(
    fontFamily: 'SF Pro Display',
    fontSize: 17,
    fontWeight: FontWeight.w400,
    color: textPrimary,
    letterSpacing: -0.41,
    height: 1.4,
  );

  static const body2 = TextStyle(
    fontFamily: 'SF Pro Display',
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: textSecondary,
    letterSpacing: -0.24,
    height: 1.4,
  );

  static const caption = TextStyle(
    fontFamily: 'SF Pro Display',
    fontSize: 13,
    fontWeight: FontWeight.w400,
    color: textSecondary,
    letterSpacing: -0.08,
    height: 1.3,
  );

  // Border Radius
  static const radiusSmall = 8.0;
  static const radiusMedium = 12.0;
  static const radiusLarge = 16.0;
  static const radiusXLarge = 24.0;

  // Spacing
  static const spacingXS = 4.0;
  static const spacingS = 8.0;
  static const spacingM = 16.0;
  static const spacingL = 24.0;
  static const spacingXL = 32.0;
}
