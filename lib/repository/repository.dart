import '../data_source/local/data_base/data_base_interface.dart';
import '../data_source/remote/api_service/api_service_interface.dart';
import '../model/movie.dart';
import '../model/movie_list.dart';
import '../resource/data_state.dart';
import '../util/string_constants.dart';
import 'repository_interface.dart';

class Repository implements RepositoryInterface {
  Repository({required this.apiService, required this.dataBase});

  final ApiServiceInterface apiService;
  final DataBaseInterface dataBase;

  @override
  Future<DataState<MovieList>> getMovieList() async {
    DataState<MovieList> movieListDataState = await apiService.getMovieList();

    switch (movieListDataState.type) {
      case DataStateType.success:
        try {
          await dataBase.openDataBase();
          await dataBase.deleteMovies();
          await dataBase.insertMovies(movieListDataState.data!.results);
          return DataSuccess(MovieList(results: await dataBase.getMovies()));
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

  Future<DataState<MovieList>> _getDataBaseMovies() async {
    try {
      await dataBase.openDataBase();
      List<Movie> movies = await dataBase.getMovies();
      if (movies.isNotEmpty) {
        return DataSuccess(MovieList(results: movies));
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
