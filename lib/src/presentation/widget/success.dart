import 'package:flutter/material.dart';

import '../../core/util/api_service_constants.dart';
import '../../core/util/string_constants.dart';
import '../../domain/entity/movie_entity.dart';
import 'movie_card.dart';
import 'movie_scaffold.dart';

class Success extends StatelessWidget {
  const Success({super.key, required this.movies, required this.callback});

  final List<MovieEntity> movies;
  final VoidCallback callback;

  @override
  Widget build(BuildContext context) {
    return MovieScaffold(
      title: StringConstants.homePageTitle,
      callBack: callback,
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
    );
  }
}
