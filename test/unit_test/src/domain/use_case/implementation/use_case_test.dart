import 'package:dojo_challenges/src/core/resource/data_state.dart';
import 'package:dojo_challenges/src/domain/entity/movie_list_entity.dart';
import 'package:dojo_challenges/src/domain/repository/repository_interface.dart';
import 'package:dojo_challenges/src/domain/use_case/implementation/use_case.dart';
import 'package:dojo_challenges/src/domain/use_case/use_case_interface.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../../mock_data/mock_data.dart';
import 'use_case_test.mocks.dart';

@GenerateMocks([RepositoryInterface])
void main() {
  late UseCaseInterface useCase;
  late RepositoryInterface repository;

  setUp(() {
    repository = MockRepositoryInterface();
    useCase = UseCase(repository: repository);
  });

  group('MovieUseCase test', () {
    test('call() should get the success state', () async {
      //Given
      when(
        repository.getMovieList(),
      ).thenAnswer((_) async => successDataStateMock);

      //When
      final response = await useCase();

      //Then
      verify(repository.getMovieList()).called(1);
      expect(response.error, null);
      assert(response is DataSuccess<MovieListEntity>);
    });

    test('call() should get the empty state', () async {
      //Given
      when(
        repository.getMovieList(),
      ).thenAnswer((_) async => emptyDataStateMock);

      //When
      final response = await useCase();

      //Then
      verify(repository.getMovieList()).called(1);
      expect(response.data, null);
      expect(response.error, null);
      assert(response is DataEmpty<MovieListEntity>);
    });

    test('call() should get the failed state', () async {
      //Given
      when(
        repository.getMovieList(),
      ).thenAnswer((_) async => failedDataStateMock);

      //When
      final response = await useCase();

      //Then
      verify(repository.getMovieList()).called(1);
      expect(response.data, null);
      expect(response.error, failedDataStateMock.error);
      assert(response is DataFailed<MovieListEntity>);
    });
  });
}
