import 'movie_entity.dart';

class MovieListEntity extends Iterable<MovieEntity> {
  MovieListEntity({
    this.page = 0,
    this.results = const [],
    this.totalPages = 0,
    this.totalResults = 0,
  });

  final int page;
  final List<MovieEntity> results;
  final int totalPages;
  final int totalResults;

  MovieListEntity copyWith({
    int? page,
    List<MovieEntity>? results,
    int? totalPages,
    int? totalResults,
  }) {
    return MovieListEntity(
      page: page ?? this.page,
      results: results ?? this.results,
      totalPages: totalPages ?? this.totalPages,
      totalResults: totalResults ?? this.totalResults,
    );
  }

  @override
  Iterator<MovieEntity> get iterator => results.iterator;
}
