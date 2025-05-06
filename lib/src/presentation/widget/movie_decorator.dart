import 'package:flutter/material.dart';

import '../../core/util/number_constants.dart';

class MovieDecorator extends StatelessWidget {
  const MovieDecorator({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: NumberConstants.movieDecoratorVerticalPadding,
        horizontal: NumberConstants.movieDecoratorHorizontalPadding,
      ),
      child: Container(
        height: NumberConstants.movieDecoratorHeight,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.blue,
            width: NumberConstants.movieDecoratorBorderWidth,
          ),
          borderRadius: BorderRadius.circular(
            NumberConstants.movieDecoratorBorderRadius,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: NumberConstants.movieDecoratorVerticalPadding,
            horizontal: NumberConstants.movieDecoratorHorizontalPadding,
          ),
          child: child,
        ),
      ),
    );
  }
}
