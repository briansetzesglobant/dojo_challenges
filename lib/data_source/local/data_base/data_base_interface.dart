import '../../../model/movie.dart';

abstract interface class DataBaseInterface {
  Future<void> openDataBase();

  Future<void> closeDataBase();

  Future<void> deleteMovies();

  Future<void> insertMovies(List<Movie> movies);

  Future<List<Movie>> getMovies();
}
