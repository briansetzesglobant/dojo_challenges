import 'package:dojo_challenges/model/movie_list.dart';

import '../resource/data_state.dart';

abstract class RepositoryInterface {
  Future<DataState<MovieList>> getMovieList();
}
