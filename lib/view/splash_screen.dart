import 'package:dojo_challenges/util/asset_constants.dart';
import 'package:flutter/material.dart';

import '../util/color_constants.dart';
import '../util/number_constants.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          AssetConstants.splashScreen,
          width: NumberConstants.imageSize,
          height: NumberConstants.imageSize,
        ),
        const SizedBox(height: NumberConstants.sizedBoxSize),
        const Center(
          child: CircularProgressIndicator(color: ColorConstants.appThemeColor),
        ),
      ],
    );
  }
}
