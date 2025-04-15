import 'package:flutter/material.dart';

import '../util/number_constants.dart';
import '../util/string_constants.dart';
import '../util/text_style_constants.dart';

class DefaultPage extends StatelessWidget {
  const DefaultPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(NumberConstants.defaultPagePadding),
          child: Text(
            StringConstants.defaultPageMessage,
            style: TextStyleConstants.defaultPageMessageTextStyle,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
