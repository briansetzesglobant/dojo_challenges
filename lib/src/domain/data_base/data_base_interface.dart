import '../../data/data_source/local/DAOs/movie_dao.dart';

abstract interface class DataBaseInterface {
  MovieDao get movieDao;

  Future<void> openDataBase();

  Future<void> closeDataBase();
}
