import 'package:flutter/material.dart';

import 'color_palette.dart';

mixin AppTheme {
  ThemeData lightTheme() => ThemeData(
        colorScheme: const ColorScheme.light().copyWith(
          primary: ColorPalette.primaryColor,
        ),
      );

  ThemeData darkTheme() => ThemeData(colorScheme: const ColorScheme.dark());
}
