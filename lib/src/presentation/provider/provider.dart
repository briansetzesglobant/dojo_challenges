import 'package:dojo_challenges/src/domain/entity/movie_list_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/resource/data_state.dart';
import '../../data/data_source/local/data_base/data_base.dart';
import '../../data/data_source/remote/api_service/api_service.dart';
import '../../data/repository/repository.dart';
import '../../data/repository/vote_count_repository.dart';
import '../../domain/api_service/api_service_interface.dart';
import '../../domain/data_base/data_base_interface.dart';
import '../../domain/repository/repository_interface.dart';
import '../../domain/use_case/implementation/use_case.dart';
import '../../domain/use_case/use_case_interface.dart';

final movieProvider = FutureProvider.family<DataState<MovieListEntity>, bool>((
  ref,
  isOriginalRepository,
) async {
  final useCaseVariable = ref.watch(useCaseProvider(isOriginalRepository));
  return await useCaseVariable();
});

final useCaseProvider = Provider.family<UseCaseInterface, bool>((
  ref,
  isOriginalRepository,
) {
  final RepositoryInterface repositoryProviderVariable;
  if (isOriginalRepository) {
    repositoryProviderVariable = ref.watch(repositoryProvider);
  } else {
    repositoryProviderVariable = ref.watch(voteCountRepositoryProvider);
  }
  return UseCase(repository: repositoryProviderVariable);
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
