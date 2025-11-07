import 'package:flutter/material.dart';

/// 2D Hand-Drawn Sketchbook Theme inspired by Japanese 2D Cafes
/// Features trompe-l'œil effects and hand-drawn aesthetics
class SketchTheme {
  // Core Colors - Black ink on paper
  static const Color inkBlack = Color(0xFF1A1A1A);
  static const Color paperWhite = Color(0xFFF5F3ED);
  static const Color sketchGray = Color(0xFF6B6B6B);
  static const Color lightGray = Color(0xFFD4D0C8);

  // Accent Colors - Subtle watercolor touches
  static const Color incomeGreen = Color(0xFF6B8E6F);
  static const Color expenseRed = Color(0xFFB85C5C);
  static const Color accentBlue = Color(0xFF5C7B9E);
  static const Color warningOrange = Color(0xFFD9946C);

  // Border and shadow for 2D effect
  static const double borderWidth = 2.5;
  static const double shadowOffset = 4.0;

  // Dark Theme Colors - Inverted sketch aesthetic
  static const Color darkPaper = Color(0xFF1E1E1E);
  static const Color darkInk = Color(0xFFE8E6E1);
  static const Color darkGray = Color(0xFF9E9E9E);
  static const Color darkBorder = Color(0xFF6B6B6B);
  static const Color darkCardBg = Color(0xFF2D2D2D);

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: paperWhite,
      colorScheme: ColorScheme.light(
        primary: inkBlack,
        secondary: accentBlue,
        surface: paperWhite,
        error: expenseRed,
        onPrimary: paperWhite,
        onSecondary: paperWhite,
        onSurface: inkBlack,
      ),

      // AppBar - clean and minimal (no borders here)
      appBarTheme: AppBarTheme(
        backgroundColor: paperWhite,
        foregroundColor: inkBlack,
        elevation: 0,
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: inkBlack,
        ),
        iconTheme: IconThemeData(color: inkBlack, size: 24),
      ),

      // Card with heavy sketch border
      cardTheme: CardThemeData(
        color: paperWhite,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
          side: BorderSide(color: inkBlack, width: borderWidth),
        ),
        margin: EdgeInsets.symmetric(vertical: 8),
      ),

      // Text styles - clean and readable
      textTheme: TextTheme(
        displayLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: inkBlack,
        ),
        displayMedium: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: inkBlack,
        ),
        titleLarge: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w600,
          color: inkBlack,
        ),
        titleMedium: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: inkBlack,
        ),
        bodyLarge: TextStyle(fontSize: 16, color: inkBlack),
        bodyMedium: TextStyle(fontSize: 14, color: sketchGray),
        labelLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: inkBlack,
        ),
      ),

      // Elevated button with 2D shadow
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: inkBlack,
          foregroundColor: paperWhite,
          elevation: 0,
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
            side: BorderSide(color: inkBlack, width: borderWidth),
          ),
          shadowColor: Colors.transparent,
        ),
      ),

      // Filled button with 2D shadow
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: inkBlack,
          foregroundColor: paperWhite,
          elevation: 0,
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
            side: BorderSide(color: inkBlack, width: borderWidth),
          ),
          shadowColor: Colors.transparent,
        ),
      ),

      // Input decoration with sketch borders
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: paperWhite,
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(0),
          borderSide: BorderSide(color: inkBlack, width: borderWidth),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(0),
          borderSide: BorderSide(color: inkBlack, width: borderWidth),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(0),
          borderSide: BorderSide(color: inkBlack, width: borderWidth + 0.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(0),
          borderSide: BorderSide(color: expenseRed, width: borderWidth),
        ),
      ),

      // FAB with 2D shadow effect
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: inkBlack,
        foregroundColor: paperWhite,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
          side: BorderSide(color: inkBlack, width: borderWidth),
        ),
      ),

      // Bottom nav - minimal
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: paperWhite,
        selectedItemColor: inkBlack,
        unselectedItemColor: sketchGray,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ),

      // Icon theme
      iconTheme: IconThemeData(color: inkBlack, size: 24),

      // Divider - hand-drawn look
      dividerTheme: DividerThemeData(
        color: inkBlack,
        thickness: 1.5,
        space: 24,
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: darkPaper,
      colorScheme: ColorScheme.dark(
        primary: darkInk,
        secondary: accentBlue,
        surface: darkCardBg,
        error: expenseRed,
        onPrimary: darkPaper,
        onSecondary: paperWhite,
        onSurface: darkInk,
        surfaceContainerHighest: Color(0xFF404040),
      ),

      // AppBar - clean and minimal
      appBarTheme: AppBarTheme(
        backgroundColor: darkPaper,
        foregroundColor: darkInk,
        elevation: 0,
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: darkInk,
        ),
        iconTheme: IconThemeData(color: darkInk, size: 24),
      ),

      // Card with heavy sketch border
      cardTheme: CardThemeData(
        color: darkCardBg,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
          side: BorderSide(color: darkBorder, width: borderWidth),
        ),
        margin: EdgeInsets.symmetric(vertical: 8),
      ),

      // Text styles - clean and readable
      textTheme: TextTheme(
        displayLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: darkInk,
        ),
        displayMedium: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: darkInk,
        ),
        titleLarge: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w600,
          color: darkInk,
        ),
        titleMedium: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: darkInk,
        ),
        bodyLarge: TextStyle(fontSize: 16, color: darkInk),
        bodyMedium: TextStyle(fontSize: 14, color: darkGray),
        labelLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: darkInk,
        ),
      ),

      // Elevated button with 2D shadow
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: darkInk,
          foregroundColor: darkPaper,
          elevation: 0,
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
            side: BorderSide(color: darkInk, width: borderWidth),
          ),
          shadowColor: Colors.transparent,
        ),
      ),

      // Filled button with 2D shadow
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: darkInk,
          foregroundColor: darkPaper,
          elevation: 0,
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
            side: BorderSide(color: darkInk, width: borderWidth),
          ),
          shadowColor: Colors.transparent,
        ),
      ),

      // Outlined button
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: darkInk,
          elevation: 0,
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
            side: BorderSide(color: darkBorder, width: borderWidth),
          ),
          shadowColor: Colors.transparent,
        ),
      ),

      // Text button
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: darkInk,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
      ),

      // Input decoration with sketch borders
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: darkCardBg,
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        labelStyle: TextStyle(color: darkGray),
        hintStyle: TextStyle(color: darkGray.withOpacity(0.6)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(0),
          borderSide: BorderSide(color: darkBorder, width: borderWidth),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(0),
          borderSide: BorderSide(color: darkBorder, width: borderWidth),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(0),
          borderSide: BorderSide(color: darkInk, width: borderWidth + 0.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(0),
          borderSide: BorderSide(color: expenseRed, width: borderWidth),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(0),
          borderSide: BorderSide(color: expenseRed, width: borderWidth + 0.5),
        ),
      ),

      // FAB with 2D shadow effect
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: darkInk,
        foregroundColor: darkPaper,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
          side: BorderSide(color: darkInk, width: borderWidth),
        ),
      ),

      // Bottom nav - minimal
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: darkPaper,
        selectedItemColor: darkInk,
        unselectedItemColor: darkGray,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ),

      // Icon theme
      iconTheme: IconThemeData(color: darkInk, size: 24),

      // Divider - hand-drawn look
      dividerTheme: DividerThemeData(
        color: darkBorder,
        thickness: 1.5,
        space: 24,
      ),

      // Switch
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return darkInk;
          }
          return darkGray;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return darkInk.withOpacity(0.5);
          }
          return darkBorder;
        }),
      ),

      // List tile
      listTileTheme: ListTileThemeData(iconColor: darkInk, textColor: darkInk),

      // Dialog
      dialogTheme: DialogThemeData(
        backgroundColor: darkCardBg,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
          side: BorderSide(color: darkBorder, width: borderWidth),
        ),
      ),

      // Bottom sheet
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: darkCardBg,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(0)),
          side: BorderSide(color: darkBorder, width: borderWidth),
        ),
      ),

      // Snackbar
      snackBarTheme: SnackBarThemeData(
        backgroundColor: darkCardBg,
        contentTextStyle: TextStyle(color: darkInk),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
          side: BorderSide(color: darkBorder, width: borderWidth),
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  // Helper to create 2D shadow effect (trompe-l'œil)
  static BoxDecoration sketchBox({
    Color? backgroundColor,
    Color borderColor = inkBlack,
  }) {
    return BoxDecoration(
      color: backgroundColor ?? paperWhite,
      border: Border.all(color: borderColor, width: borderWidth),
      boxShadow: [
        BoxShadow(
          color: inkBlack,
          offset: Offset(shadowOffset, shadowOffset),
          blurRadius: 0,
        ),
      ],
    );
  }
}
