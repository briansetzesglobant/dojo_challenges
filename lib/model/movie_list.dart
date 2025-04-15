import 'movie.dart';

class MovieList {
  MovieList({
    this.page = 0,
    this.results = const [],
    this.totalPages = 0,
    this.totalResults = 0,
  });

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

  final int page;
  final List<Movie> results;
  final int totalPages;
  final int totalResults;
}
