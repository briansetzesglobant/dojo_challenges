import 'package:flutter/material.dart';

import '../util/color_constants.dart';
import '../util/number_constants.dart';
import '../util/string_constants.dart';
import '../util/text_style_constants.dart';

class MovieScaffold extends StatelessWidget {
  const MovieScaffold({
    super.key,
    this.title,
    this.backgroundColor,
    this.callBack,
    required this.child,
  });

  final String? title;
  final Color? backgroundColor;
  final VoidCallback? callBack;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: title != null ? AppBar(title: Text(title!)) : null,
      backgroundColor: backgroundColor,
      body: SafeArea(child: child),
      bottomNavigationBar:
          callBack != null
              ? Padding(
                padding: const EdgeInsets.all(
                  NumberConstants.movieScaffoldButtonPadding,
                ),
                child: ElevatedButton(
                  onPressed: callBack,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorConstants.appThemeColor,
                  ),
                  child: const Text(
                    StringConstants.movieScaffoldButtonText,
                    style: TextStyleConstants.movieScaffoldButtonTextStyle,
                    textAlign: TextAlign.center,
                  ),
                ),
              )
              : null,
    );
  }
}
