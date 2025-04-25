import '../../../model/movie_list.dart';
import '../../../resource/data_state.dart';

abstract interface class ApiServiceInterface {
  Future<DataState<MovieList>> getMovieList();
}
