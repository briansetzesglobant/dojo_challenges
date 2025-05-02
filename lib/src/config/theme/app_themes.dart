import 'package:flutter/material.dart';

import '../../core/util/color_constants.dart';

abstract class AppThemes {
  static ThemeData appTheme = ThemeData(
    appBarTheme: const AppBarTheme(
      color: ColorConstants.appThemeColor,
      centerTitle: true,
    ),
  );
}
