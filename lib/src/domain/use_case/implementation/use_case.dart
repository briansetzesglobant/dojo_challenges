import '../../../core/resource/data_state.dart';
import '../../entity/movie_list_entity.dart';
import '../../repository/repository_interface.dart';
import '../use_case_interface.dart';

class UseCase<T> implements UseCaseInterface<DataState<MovieListEntity>> {
  UseCase({required this.repository});

  final RepositoryInterface repository;

  @override
  Future<DataState<MovieListEntity>> call() async {
    return await repository.getMovieList();
  }
}
