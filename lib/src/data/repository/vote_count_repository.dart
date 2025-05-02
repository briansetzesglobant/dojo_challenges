import '../../core/resource/data_state.dart';
import '../../core/util/number_constants.dart';
import '../../domain/entity/movie_list_entity.dart';
import '../model/movie_list.dart';
import 'repository.dart';

class VoteCountRepository extends Repository {
  VoteCountRepository({required super.apiService, required super.dataBase});

  @override
  Future<DataState<MovieListEntity>> getMovieList() async {
    DataState<MovieListEntity> movieListDataState = await super.getMovieList();
    if (movieListDataState.type == DataStateType.success) {
      return DataSuccess(
        MovieList(
          page: movieListDataState.data!.page,
          results:
              movieListDataState.data!.results
                  .where(
                    (movie) =>
                        movie.voteCount >=
                        NumberConstants.voteCountRepositoryCondition,
                  )
                  .toList(),
          totalResults: movieListDataState.data!.totalResults,
          totalPages: movieListDataState.data!.totalPages,
        ),
      );
    } else {
      return movieListDataState;
    }
  }
}
