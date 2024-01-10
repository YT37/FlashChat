import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: avoid_classes_with_only_static_members
class FlashChatTheme {
  static ThemeData of(BuildContext context) {
    final TextTheme _font = GoogleFonts.poppinsTextTheme();
    final TextTheme _textTheme = _font.copyWith(
      displayLarge: _font.displayLarge!.copyWith(
        fontSize: 32,
        fontWeight: FontWeight.bold,
      ),
      displayMedium: _font.displayMedium!.copyWith(
        fontSize: 26,
        fontWeight: FontWeight.normal,
      ),
      displaySmall: _font.displaySmall!.copyWith(
        fontSize: 22,
        fontWeight: FontWeight.normal,
      ),
      titleLarge: _font.titleLarge!.copyWith(
        fontWeight: FontWeight.w900,
        fontSize: 18,
      ),
      titleMedium: _font.titleMedium!.copyWith(
        fontWeight: FontWeight.w600,
        fontSize: 16,
      ),
    );

    final ColorScheme _colorScheme = const ColorScheme.light().copyWith(
      primary: const Color(0xFFFFFFFF),
      onPrimary: const Color(0xff000000),
      secondary: const Color(0xFF368F8B),
      onSecondary: const Color(0xFFFFFFFF),
      tertiary: const Color(0xFFEE7B30),
      onTertiary: const Color(0xFF000000),
    );

    return ThemeData(
      useMaterial3: true,
      hoverColor: Colors.grey.shade100,
      colorScheme: _colorScheme,
      textTheme: _textTheme,
      appBarTheme: AppBarTheme(
        backgroundColor: _colorScheme.primary,
        surfaceTintColor: _colorScheme.primary,
        shadowColor: _colorScheme.primary,
        centerTitle: true,
      ),
      popupMenuTheme: PopupMenuThemeData(
        elevation: 5,
        color: _colorScheme.primary,
        surfaceTintColor: _colorScheme.primary,
        iconColor: _colorScheme.onPrimary,
      ),
      tooltipTheme: const TooltipThemeData(
        margin: EdgeInsets.all(5),
      ),
      cardTheme: CardTheme(
        elevation: 5,
        shadowColor: _colorScheme.primary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      dividerTheme: DividerThemeData(
        thickness: 1.25,
        space: 15,
        color: _colorScheme.onPrimary,
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          textStyle: MaterialStateProperty.all<TextStyle>(
            _textTheme.titleLarge!.copyWith(color: _colorScheme.secondary),
          ),
          padding:
              MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(12)),
          overlayColor: MaterialStateProperty.all<Color>(
            _colorScheme.secondary.withAlpha(50),
          ),
          foregroundColor:
              MaterialStateProperty.all<Color>(_colorScheme.secondary),
          shape: MaterialStateProperty.all<OutlinedBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(color: _colorScheme.secondary, width: 0.75),
            ),
          ),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: ButtonStyle(
          textStyle: MaterialStateProperty.all<TextStyle>(
            _textTheme.titleLarge!.copyWith(color: _colorScheme.onTertiary),
          ),
          padding:
              MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(12)),
          backgroundColor:
              MaterialStateProperty.all<Color>(_colorScheme.tertiary),
          shape: MaterialStateProperty.all<OutlinedBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(color: _colorScheme.tertiary, width: 0.75),
            ),
          ),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          shape: const StadiumBorder(),
          backgroundColor: _colorScheme.primary,
          maximumSize: const Size(double.infinity, 56),
          minimumSize: const Size(double.infinity, 56),
        ),
      ),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: Colors.grey.shade700,
        selectionColor: Colors.grey.shade500,
        selectionHandleColor: Colors.grey.shade700,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.grey.shade200,
        iconColor: Colors.grey.shade600,
        prefixIconColor: Colors.grey.shade600,
        contentPadding: const EdgeInsets.all(12),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
      ),
      scrollbarTheme: ScrollbarThemeData(
        interactive: true,
        thumbColor: MaterialStateProperty.all(Colors.grey.shade700),
        thickness: MaterialStateProperty.all(7),
        radius: const Radius.circular(20),
      ),
      snackBarTheme: SnackBarThemeData(
        elevation: 10,
        backgroundColor: _colorScheme.secondary,
        contentTextStyle: TextStyle(color: _colorScheme.primary),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        elevation: 10,
        foregroundColor: _colorScheme.primary,
        backgroundColor: _colorScheme.secondary,
      ),
    );
  }
}
