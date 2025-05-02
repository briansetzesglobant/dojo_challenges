import 'package:flutter/material.dart';

import '../../core/util/color_constants.dart';
import '../../core/util/number_constants.dart';
import '../../core/util/string_constants.dart';
import '../../core/util/text_style_constants.dart';

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
