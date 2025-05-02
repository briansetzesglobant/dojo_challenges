import '../../core/resource/data_state.dart';
import '../entity/movie_list_entity.dart';

abstract interface class ApiServiceInterface {
  Future<DataState<MovieListEntity>> getMovieList();
}
