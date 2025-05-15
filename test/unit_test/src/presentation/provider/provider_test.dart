import 'package:dojo_challenges/src/core/resource/data_state.dart';
import 'package:dojo_challenges/src/data/data_source/local/DAOs/movie_dao.dart';
import 'package:dojo_challenges/src/data/data_source/local/data_base/data_base.dart';
import 'package:dojo_challenges/src/data/data_source/remote/api_service/api_service.dart';
import 'package:dojo_challenges/src/data/repository/repository.dart';
import 'package:dojo_challenges/src/data/repository/vote_count_repository.dart';
import 'package:dojo_challenges/src/domain/api_service/api_service_interface.dart';
import 'package:dojo_challenges/src/domain/data_base/data_base_interface.dart';
import 'package:dojo_challenges/src/domain/entity/movie_list_entity.dart';
import 'package:dojo_challenges/src/domain/repository/repository_interface.dart';
import 'package:dojo_challenges/src/domain/use_case/implementation/use_case.dart';
import 'package:dojo_challenges/src/domain/use_case/use_case_interface.dart';
import 'package:dojo_challenges/src/presentation/provider/provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../mock_data/mock_data.dart';
import 'provider_test.mocks.dart';

@GenerateMocks([
  UseCaseInterface,
  RepositoryInterface,
  ApiServiceInterface,
  Client,
  DataBaseInterface,
  MovieDao,
])
void main() {
  late UseCaseInterface useCase;
  late RepositoryInterface repository;
  late ApiServiceInterface apiService;
  late Client client;
  late DataBaseInterface dataBase;
  late MovieDao movieDao;

  setUp(() {
    useCase = MockUseCaseInterface();
    repository = MockRepositoryInterface();
    apiService = MockApiServiceInterface();
    client = MockClient();
    dataBase = MockDataBaseInterface();
    movieDao = MockMovieDao();
  });

  test('movieProvider should get the success state', () async {
    //Given
    when(useCase()).thenAnswer((_) async => successDataStateMock);
    final container = ProviderContainer(
      overrides: [useCaseProvider.overrideWith((ref, _) async => useCase)],
    );
    addTearDown(container.dispose);

    //When
    final response = await container.read(movieProvider(true).future);

    //Then
    verify(useCase()).called(1);
    expect(response.data, movieListMock);
    expect(response.error, null);
    assert(response is DataSuccess<MovieListEntity>);
  });

  test('movieProvider should get the empty state', () async {
    //Given
    when(useCase()).thenAnswer((_) async => emptyDataStateMock);
    final container = ProviderContainer(
      overrides: [useCaseProvider.overrideWith((ref, _) async => useCase)],
    );
    addTearDown(container.dispose);

    //When
    final response = await container.read(movieProvider(true).future);

    //Then
    verify(useCase()).called(1);
    expect(response.data, null);
    expect(response.error, null);
    assert(response is DataEmpty<MovieListEntity>);
  });

  test('movieProvider should get the failed state', () async {
    //Given
    when(useCase()).thenAnswer((_) async => failedDataStateMock);
    final container = ProviderContainer(
      overrides: [useCaseProvider.overrideWith((ref, _) async => useCase)],
    );
    addTearDown(container.dispose);

    //When
    final response = await container.read(movieProvider(true).future);

    //Then
    verify(useCase()).called(1);
    expect(response.data, null);
    expect(response.error, failedDataStateMock.error);
    assert(response is DataFailed<MovieListEntity>);
  });

  test('useCaseProvider should get the use case with repository', () async {
    //Given
    final container = ProviderContainer(
      overrides: [repositoryProvider.overrideWith((ref) async => repository)],
    );
    addTearDown(container.dispose);

    //When
    final response = await container.read(useCaseProvider(true).future);

    //Then
    assert(response is UseCase);
  });

  test(
    'useCaseProvider should get the use case with vote count repository',
    () async {
      //Given
      final container = ProviderContainer(
        overrides: [
          voteCountRepositoryProvider.overrideWith((ref) async => repository),
        ],
      );
      addTearDown(container.dispose);

      //When
      final response = await container.read(useCaseProvider(false).future);

      //Then
      assert(response is UseCase);
    },
  );

  test('repositoryProvider should get the repository', () async {
    //Given
    when(dataBase.movieDao).thenAnswer((_) => movieDao);
    final container = ProviderContainer(
      overrides: [
        apiServiceProvider.overrideWithValue(apiService),
        dataBaseProvider.overrideWith((ref) async => dataBase),
      ],
    );
    addTearDown(container.dispose);

    //When
    final response = await container.read(repositoryProvider.future);

    //Then
    verify(dataBase.movieDao).called(1);
    assert(response is Repository);
  });

  test(
    'voteCountRepositoryProvider should get the vote count repository',
    () async {
      //Given
      when(dataBase.movieDao).thenAnswer((_) => movieDao);
      final container = ProviderContainer(
        overrides: [
          apiServiceProvider.overrideWith((ref) => apiService),
          dataBaseProvider.overrideWith((ref) async => dataBase),
        ],
      );
      addTearDown(container.dispose);

      //When
      final response = await container.read(voteCountRepositoryProvider.future);

      //Then
      verify(dataBase.movieDao).called(1);
      assert(response is VoteCountRepository);
    },
  );

  test('apiServiceProvider should get the api service', () async {
    //Given
    final container = ProviderContainer(
      overrides: [clientProvider.overrideWithValue(client)],
    );
    addTearDown(container.dispose);

    //When
    final response = container.read(apiServiceProvider);

    //Then
    assert(response is ApiService);
  });

  test('clientProvider should get the client', () async {
    //Given
    final container = ProviderContainer();
    addTearDown(container.dispose);

    //When
    final response = container.read(clientProvider);

    //Then
    expect(response, isA<Client>());
  });

  test('dataBaseProvider should get the mock data base interface', () async {
    //Given
    when(dataBase.openDataBase()).thenAnswer((_) => Future.value());
    when(dataBase.closeDataBase()).thenAnswer((_) => Future.value());
    final container = ProviderContainer(
      overrides: [dataBaseInstanceProvider.overrideWithValue(dataBase)],
    );
    addTearDown(container.dispose);

    //When
    final response = await container.read(dataBaseProvider.future);
    container.dispose();

    //Then
    verify(dataBase.openDataBase()).called(1);
    verify(dataBase.closeDataBase()).called(1);
    assert(response is MockDataBaseInterface);
  });

  test('dataBaseProvider should get the mock data base interface', () async {
    //Given
    final exception = Exception();
    when(dataBase.openDataBase()).thenAnswer((_) => Future.value());
    when(dataBase.closeDataBase()).thenThrow((_) => exception);
    final container = ProviderContainer(
      overrides: [dataBaseInstanceProvider.overrideWithValue(dataBase)],
    );
    addTearDown(container.dispose);

    //When
    final response = await container.read(dataBaseProvider.future);
    container.dispose();

    //Then
    verify(dataBase.openDataBase()).called(1);
    verify(dataBase.closeDataBase()).called(1);
    assert(response is MockDataBaseInterface);
  });

  test('dataBaseInstanceProvider should get the data base', () async {
    //Given
    final container = ProviderContainer();
    addTearDown(container.dispose);

    //When
    final response = container.read(dataBaseInstanceProvider);

    //Then
    assert(response is DataBase);
  });
}
