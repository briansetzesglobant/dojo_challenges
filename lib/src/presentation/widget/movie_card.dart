import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../core/util/asset_constants.dart';
import '../../core/util/number_constants.dart';
import '../../core/util/text_style_constants.dart';
import 'movie_decorator.dart';

class MovieCard extends StatelessWidget {
  const MovieCard({super.key, required this.title, required this.image});

  final String title;
  final String image;

  @override
  Widget build(BuildContext context) {
    return MovieDecorator(
      child: Column(
        children: [
          FittedBox(
            child: Text(
              title,
              style: TextStyleConstants.movieCardTitleTextStyle,
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: NumberConstants.movieCardSizedBox),
          Expanded(
            child: ClipOval(
              child: CachedNetworkImage(
                imageUrl: image,
                placeholder:
                    (_, _) => Image.asset(
                      AssetConstants.movieCardPlaceholder,
                      width: NumberConstants.movieCardCachedNetworkImageSize,
                      height: NumberConstants.movieCardCachedNetworkImageSize,
                    ),
                errorWidget:
                    (_, _, _) => Image.asset(
                      AssetConstants.movieCardPlaceholder,
                      width: NumberConstants.movieCardCachedNetworkImageSize,
                      height: NumberConstants.movieCardCachedNetworkImageSize,
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
