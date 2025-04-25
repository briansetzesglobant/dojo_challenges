import '../model/movie_list.dart';
import '../resource/data_state.dart';

abstract interface class RepositoryInterface {
  Future<DataState<MovieList>> getMovieList();
}
