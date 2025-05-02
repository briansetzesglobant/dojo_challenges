import '../entity/movie_entity.dart';

abstract interface class DataBaseInterface {
  Future<void> openDataBase();

  Future<void> closeDataBase();

  Future<void> deleteMovies();

  Future<void> insertMovies(List<MovieEntity> movies);

  Future<List<MovieEntity>> getMovies();
}
