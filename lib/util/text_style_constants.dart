import 'package:flutter/material.dart';

import 'color_constants.dart';
import 'number_constants.dart';

abstract class TextStyleConstants {
  static const TextStyle homePageErrorMessageTextStyle = TextStyle(
    fontSize: NumberConstants.homePageErrorMessageTextStyleFontSize,
    color: ColorConstants.appThemeColor,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle movieCardTitleTextStyle = TextStyle(
    fontSize: NumberConstants.movieCardTitleTextStyleFontSize,
    color: Colors.grey,
    decoration: TextDecoration.underline,
  );

  static const TextStyle defaultPageMessageTextStyle = TextStyle(
    fontSize: NumberConstants.defaultPageMessageTextStyleFontSize,
    color: Colors.red,
    fontWeight: FontWeight.bold,
  );
}
