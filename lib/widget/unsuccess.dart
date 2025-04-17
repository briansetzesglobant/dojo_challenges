import 'package:flutter/material.dart';

import '../util/number_constants.dart';
import '../util/text_style_constants.dart';

class Unsuccess extends StatelessWidget {
  const Unsuccess({super.key, required this.text, required this.image});

  final String text;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(NumberConstants.unsuccessPadding),
          child: Column(
            children: [
              Image.asset(
                image,
                width: NumberConstants.imageSize,
                height: NumberConstants.imageSize,
              ),
              const SizedBox(height: NumberConstants.sizedBoxSize),
              Text(
                text,
                style: TextStyleConstants.homePageUnsuccessMessageTextStyle,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
