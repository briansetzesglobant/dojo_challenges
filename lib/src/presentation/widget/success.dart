import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/util/api_service_constants.dart';
import '../../core/util/color_constants.dart';
import '../../core/util/number_constants.dart';
import '../../core/util/route_constants.dart';
import '../../core/util/string_constants.dart';
import '../../core/util/text_style_constants.dart';
import '../../di/provider/provider.dart';
import '../../domain/entity/movie_entity.dart';
import 'movie_card.dart';
import 'movie_scaffold.dart';

class Success extends ConsumerWidget {
  const Success({super.key, required this.movies, required this.callback});

  final List<MovieEntity> movies;
  final VoidCallback callback;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MovieScaffold(
      title: StringConstants.homePageTitle,
      callBack: callback,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(
              NumberConstants.successButtonsPadding,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    ref.read(makeABackupProvider);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorConstants.appThemeColor,
                  ),
                  child: Text(
                    StringConstants.successMakeABackupButtonText,
                    style: TextStyleConstants.generaTextStyle,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(RouteConstants.backupRoute);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorConstants.appThemeColor,
                  ),
                  child: Text(
                    StringConstants.successShowBackupContentButtonText,
                    style: TextStyleConstants.generaTextStyle,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: movies.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: MovieCard(
                    title: movies[index].title,
                    image:
                        '${ApiServiceConstants.imageNetwork}${movies[index].posterPath}',
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
