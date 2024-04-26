import 'package:blogapp/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static _border([Color c = AppPallete.borderColor]) => OutlineInputBorder(
        borderSide: BorderSide(color: c, width: 3),
      );

  static final darkTheme = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: AppPallete.backgroundColor,
    chipTheme: const ChipThemeData(
        color: MaterialStatePropertyAll(
          AppPallete.backgroundColor,
        ),
        side: BorderSide.none),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(27),
      border: _border(),
      enabledBorder: _border(),
      focusedBorder: _border(AppPallete.gradient2),
      errorBorder: _border(AppPallete.errorColor),
    ),
  );
}
