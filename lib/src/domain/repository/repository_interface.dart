import '../../core/resource/data_state.dart';
import '../entity/movie_list_entity.dart';

abstract interface class RepositoryInterface {
  Future<DataState<MovieListEntity>> getMovieList();
}
