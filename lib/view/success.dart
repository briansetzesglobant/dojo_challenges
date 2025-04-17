import 'package:flutter/material.dart';

import '../model/movie.dart';
import '../util/api_service_constants.dart';
import '../widget/movie_card.dart';

class Success extends StatelessWidget {
  const Success({super.key, required this.movies});

  final List<Movie> movies;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
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
    );
  }
}
