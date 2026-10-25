import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract final class AppPalette {
  // Warna utama
  static const primary = Color(0xFF676DE3);
  static const primaryDark = Color(0xFF2C315F);
  static const pink = Color(0xFFE9A7D5);
  static const accent = Color(0xFF91EC59);

  // Latar dan permukaan
  static const background = Color(0xFFF2F1FF);
  static const surface = Color(0xFFFFFFFF);
  static const glass = Color(0xBFFFFFFF);
  static const glassBorder = Color(0x99FFFFFF);

  // Warna teks
  static const text = Color(0xFF282D4B);
  static const muted = Color(0xFF7D829D);

  // Warna pendukung
  static const border = Color(0xFFE0E4F4);
  static const danger = Color(0xFFD76582);
  static const lilac = Color(0xFFE7E9FF);
  static const blush = Color(0xFFFBEAF7);
  static const mint = Color(0xFFE5F6EA);
  static const navigation = Color(0xFF202235);

  // Warna dekorasi glassmorphism
  static const purpleGlow = Color(0x337D72F2);
  static const pinkGlow = Color(0x33E9A7D5);
}

abstract final class AppTheme {
  static ThemeData get light {
    const primary = AppPalette.primary;

    final scheme =
        ColorScheme.fromSeed(
          seedColor: primary,
          brightness: Brightness.light,
        ).copyWith(
          primary: primary,
          onPrimary: Colors.white,
          secondary: AppPalette.pink,
          surface: AppPalette.surface,
          onSurface: AppPalette.text,
          error: AppPalette.danger,
        );

    const textTheme = TextTheme(
      displayLarge: TextStyle(
        fontFamily: 'Manrope',
        fontSize: 32,
        fontWeight: FontWeight.w800,
        letterSpacing: -1.2,
        color: AppPalette.primaryDark,
      ),
      headlineLarge: TextStyle(
        fontFamily: 'Manrope',
        fontSize: 29,
        fontWeight: FontWeight.w800,
        letterSpacing: -0.8,
        color: AppPalette.primaryDark,
      ),
      headlineMedium: TextStyle(
        fontFamily: 'Manrope',
        fontSize: 25,
        fontWeight: FontWeight.w800,
        letterSpacing: -0.5,
        color: AppPalette.primaryDark,
      ),
      titleLarge: TextStyle(
        fontFamily: 'Manrope',
        fontSize: 19,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.3,
        color: AppPalette.primaryDark,
      ),
      titleMedium: TextStyle(
        fontFamily: 'Manrope',
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color: AppPalette.primaryDark,
      ),
      bodyLarge: TextStyle(
        fontFamily: 'Manrope',
        fontSize: 15,
        height: 1.5,
        color: AppPalette.text,
      ),
      bodyMedium: TextStyle(
        fontFamily: 'Manrope',
        fontSize: 13,
        height: 1.45,
        color: AppPalette.muted,
      ),
      bodySmall: TextStyle(
        fontFamily: 'Manrope',
        fontSize: 11,
        height: 1.4,
        color: AppPalette.muted,
      ),
      labelLarge: TextStyle(
        fontFamily: 'Manrope',
        fontSize: 14,
        fontWeight: FontWeight.w700,
      ),
    );

    return ThemeData(
      useMaterial3: true,
      fontFamily: 'Manrope',
      scaffoldBackgroundColor: Colors.transparent,
      colorScheme: scheme,
      textTheme: GoogleFonts.manropeTextTheme(textTheme),

      // App bar
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        foregroundColor: AppPalette.primaryDark,
        centerTitle: false,
        elevation: 0,
        scrolledUnderElevation: 0,
        titleTextStyle: TextStyle(
          fontFamily: 'Manrope',
          fontSize: 21,
          fontWeight: FontWeight.w800,
          color: AppPalette.primaryDark,
        ),
      ),

      // Kartu
      cardTheme: CardThemeData(
        color: AppPalette.glass,
        elevation: 0,
        margin: EdgeInsets.zero,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
          side: const BorderSide(color: AppPalette.glassBorder, width: 1),
        ),
      ),

      // Kolom input dan pencarian
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppPalette.glass,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 17,
          vertical: 15,
        ),
        hintStyle: const TextStyle(
          fontFamily: 'Manrope',
          fontSize: 13,
          color: AppPalette.muted,
        ),
        labelStyle: const TextStyle(
          fontFamily: 'Manrope',
          color: AppPalette.muted,
        ),
        prefixIconColor: AppPalette.primary,
        suffixIconColor: AppPalette.muted,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(color: AppPalette.glassBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(color: AppPalette.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(color: AppPalette.primary, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(color: AppPalette.danger),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(color: AppPalette.danger, width: 1.5),
        ),
      ),

      // Tombol utama
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppPalette.primary,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          textStyle: const TextStyle(
            fontFamily: 'Manrope',
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),

      // Tombol berisi warna tema
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: AppPalette.primary,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          textStyle: const TextStyle(
            fontFamily: 'Manrope',
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),

      // Tombol outline
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppPalette.primaryDark,
          side: const BorderSide(color: AppPalette.border),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 13),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          textStyle: const TextStyle(
            fontFamily: 'Manrope',
            fontSize: 13,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),

      // Tombol teks
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppPalette.primary,
          textStyle: const TextStyle(
            fontFamily: 'Manrope',
            fontWeight: FontWeight.w700,
          ),
        ),
      ),

      // Chip kategori
      chipTheme: ChipThemeData(
        backgroundColor: AppPalette.glass,
        selectedColor: AppPalette.lilac,
        disabledColor: AppPalette.border,
        secondarySelectedColor: AppPalette.lilac,
        labelStyle: const TextStyle(
          fontFamily: 'Manrope',
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: AppPalette.muted,
        ),
        secondaryLabelStyle: const TextStyle(
          fontFamily: 'Manrope',
          fontSize: 12,
          fontWeight: FontWeight.w700,
          color: AppPalette.primaryDark,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
          side: const BorderSide(color: AppPalette.border),
        ),
      ),

      // Navigasi bawah
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: AppPalette.navigation,
        indicatorColor: AppPalette.accent,
        elevation: 0,
        height: 70,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
        iconTheme: WidgetStateProperty.resolveWith(
          (states) => IconThemeData(
            size: 24,
            color: states.contains(WidgetState.selected)
                ? AppPalette.primaryDark
                : Colors.white70,
          ),
        ),
      ),

      // Navigasi samping dan daftar
      listTileTheme: const ListTileThemeData(
        iconColor: AppPalette.primary,
        textColor: AppPalette.primaryDark,
        contentPadding: EdgeInsets.symmetric(horizontal: 17, vertical: 5),
        minLeadingWidth: 28,
      ),

      // Dialog
      dialogTheme: DialogThemeData(
        backgroundColor: AppPalette.surface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(26),
          side: const BorderSide(color: AppPalette.glassBorder),
        ),
        titleTextStyle: textTheme.titleLarge,
        contentTextStyle: textTheme.bodyLarge,
      ),

      // Switch
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected)
              ? AppPalette.primary
              : Colors.white,
        ),
        trackColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected)
              ? AppPalette.lilac
              : AppPalette.border,
        ),
      ),

      // Snackbar
      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppPalette.navigation,
        contentTextStyle: const TextStyle(
          fontFamily: 'Manrope',
          color: Colors.white,
          fontSize: 13,
        ),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),

      // Garis pemisah
      dividerTheme: const DividerThemeData(
        color: AppPalette.border,
        thickness: 1,
        space: 1,
      ),
    );
  }
}
