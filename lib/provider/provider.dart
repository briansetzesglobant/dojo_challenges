import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data_source/local/data_base/data_base.dart';
import '../data_source/local/data_base/data_base_interface.dart';
import '../data_source/remote/api_service/api_service.dart';
import '../data_source/remote/api_service/api_service_interface.dart';
import '../model/movie_list.dart';
import '../repository/repository.dart';
import '../repository/repository_interface.dart';
import '../repository/vote_count_repository.dart';
import '../resource/data_state.dart';

final movieProvider = FutureProvider.family<DataState<MovieList>, bool>((
  ref,
  isOriginalRepository,
) async {
  final RepositoryInterface repositoryProviderVariable;
  if (isOriginalRepository) {
    repositoryProviderVariable = ref.watch(repositoryProvider);
  } else {
    repositoryProviderVariable = ref.watch(voteCountRepositoryProvider);
  }
  return await repositoryProviderVariable.getMovieList();
});

final repositoryProvider = Provider<RepositoryInterface>((ref) {
  final apiServiceProviderVariable = ref.watch(apiServiceProvider);
  final dataBaseProviderVariable = ref.watch(dataBaseProvider);
  return Repository(
    apiService: apiServiceProviderVariable,
    dataBase: dataBaseProviderVariable,
  );
});

final voteCountRepositoryProvider = Provider<RepositoryInterface>((ref) {
  final apiServiceProviderVariable = ref.watch(apiServiceProvider);
  final dataBaseProviderVariable = ref.watch(dataBaseProvider);
  return VoteCountRepository(
    apiService: apiServiceProviderVariable,
    dataBase: dataBaseProviderVariable,
  );
});

final apiServiceProvider = Provider<ApiServiceInterface>((ref) {
  return ApiService();
});

final dataBaseProvider = Provider<DataBaseInterface>((ref) {
  return DataBase.instance;
});
