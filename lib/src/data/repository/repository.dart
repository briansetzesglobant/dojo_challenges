import '../../core/resource/data_state.dart';
import '../../core/util/string_constants.dart';
import '../../domain/api_service/api_service_interface.dart';
import '../../domain/entity/movie_entity.dart';
import '../../domain/entity/movie_list_entity.dart';
import '../../domain/repository/repository_interface.dart';
import '../data_source/local/DAOs/movie_dao.dart';

class Repository implements RepositoryInterface {
  Repository({required this.apiService, required this.movieDao});

  final ApiServiceInterface apiService;
  final MovieDao movieDao;

  @override
  Future<DataState<MovieListEntity>> getMovieList() async {
    DataState<MovieListEntity> movieListDataState =
        await apiService.getMovieList();

    switch (movieListDataState.type) {
      case DataStateType.success:
        try {
          await movieDao.deleteMovies();
          await movieDao.insertMovies(movieListDataState.data!.results);
          return DataSuccess(
            movieListDataState.data!.copyWith(
              results: await movieDao.getMovies(),
            ),
          );
        } catch (exception) {
          return DataFailed(
            '${StringConstants.errorMessage}: ${exception.toString()}',
          );
        }
      case DataStateType.empty:
      case DataStateType.error:
        return await _getDataBaseMovies();
    }
  }

  Future<DataState<MovieListEntity>> _getDataBaseMovies() async {
    try {
      List<MovieEntity> movies = await movieDao.getMovies();
      if (movies.isNotEmpty) {
        return DataSuccess(MovieListEntity(results: movies));
      } else {
        return const DataEmpty();
      }
    } catch (exception) {
      return DataFailed(
        '${StringConstants.errorMessage}: ${exception.toString()}',
      );
    }
  }
}
