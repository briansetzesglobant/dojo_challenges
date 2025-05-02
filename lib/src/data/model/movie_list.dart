import '../../domain/entity/movie_list_entity.dart';
import 'movie.dart';

class MovieList extends MovieListEntity {
  MovieList({super.page, super.results, super.totalPages, super.totalResults});

  factory MovieList.fromJson(Map<String, dynamic> json) {
    List jsonList = (json['results'] ?? []) as List;
    List<Movie> movieList =
        jsonList.map((movie) => Movie.fromJson(movie)).toList();
    return MovieList(
      page: json['page'] ?? 0,
      results: movieList,
      totalPages: json['total_pages'] ?? 0,
      totalResults: json['total_results'] ?? 0,
    );
  }
}
