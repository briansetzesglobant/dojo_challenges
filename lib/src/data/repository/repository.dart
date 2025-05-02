import '../../core/resource/data_state.dart';
import '../../core/util/string_constants.dart';
import '../../domain/api_service/api_service_interface.dart';
import '../../domain/data_base/data_base_interface.dart';
import '../../domain/entity/movie_entity.dart';
import '../../domain/entity/movie_list_entity.dart';
import '../../domain/repository/repository_interface.dart';

class Repository implements RepositoryInterface {
  Repository({required this.apiService, required this.dataBase});

  final ApiServiceInterface apiService;
  final DataBaseInterface dataBase;

  @override
  Future<DataState<MovieListEntity>> getMovieList() async {
    DataState<MovieListEntity> movieListDataState =
        await apiService.getMovieList();

    switch (movieListDataState.type) {
      case DataStateType.success:
        try {
          await dataBase.openDataBase();
          await dataBase.deleteMovies();
          await dataBase.insertMovies(movieListDataState.data!.results);
          return DataSuccess(
            MovieListEntity(results: await dataBase.getMovies()),
          );
        } catch (exception) {
          return DataFailed(
            '${StringConstants.errorMessage}: ${exception.toString()}',
          );
        } finally {
          await dataBase.closeDataBase();
        }
      case DataStateType.empty:
      case DataStateType.error:
        return await _getDataBaseMovies();
    }
  }

  Future<DataState<MovieListEntity>> _getDataBaseMovies() async {
    try {
      await dataBase.openDataBase();
      List<MovieEntity> movies = await dataBase.getMovies();
      if (movies.isNotEmpty) {
        return DataSuccess(MovieListEntity(results: movies));
      } else {
        return const DataEmpty();
      }
    } catch (exception) {
      return DataFailed(
        '${StringConstants.errorMessage}: ${exception.toString()}',
      );
    } finally {
      await dataBase.closeDataBase();
    }
  }
}
