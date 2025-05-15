import 'package:dojo_challenges/src/core/resource/data_state.dart';
import 'package:dojo_challenges/src/core/util/string_constants.dart';
import 'package:dojo_challenges/src/data/data_source/local/DAOs/movie_dao.dart';
import 'package:dojo_challenges/src/data/repository/vote_count_repository.dart';
import 'package:dojo_challenges/src/domain/api_service/api_service_interface.dart';
import 'package:dojo_challenges/src/domain/entity/movie_list_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../mock_data/mock_data.dart';
import 'repository_test.mocks.dart';

@GenerateMocks([ApiServiceInterface, MovieDao])
void main() {
  late VoteCountRepository voteCountRepository;
  late ApiServiceInterface apiService;
  late MovieDao movieDao;

  setUp(() {
    apiService = MockApiServiceInterface();
    movieDao = MockMovieDao();
    voteCountRepository = VoteCountRepository(
      apiService: apiService,
      movieDao: movieDao,
    );
  });

  group('VoteCountRepository test', () {
    test('getMovieList() should get the success state', () async {
      //Given
      when(
        apiService.getMovieList(),
      ).thenAnswer((_) async => successDataStateMock);
      when(movieDao.deleteMovies()).thenAnswer((_) async => Future.value());
      when(
        movieDao.insertMovies([movieMock, voteCountMovieMock]),
      ).thenAnswer((_) async => Future.value());
      when(
        movieDao.getMovies(),
      ).thenAnswer((_) async => [movieMock, voteCountMovieMock]);

      //When
      final response = await voteCountRepository.getMovieList();

      //Then
      verify(apiService.getMovieList()).called(1);
      verify(movieDao.deleteMovies()).called(1);
      verify(movieDao.insertMovies([movieMock, voteCountMovieMock])).called(1);
      verify(movieDao.getMovies()).called(1);
      expect(response.data!.results.length, 1);
      expect(response.data!.results.first, voteCountMovieMock);
      expect(response.error, null);
      assert(response is DataSuccess<MovieListEntity>);
    });

    test('getMovieList() should get the empty state', () async {
      //Given
      when(
        apiService.getMovieList(),
      ).thenAnswer((_) async => emptyDataStateMock);
      when(movieDao.getMovies()).thenAnswer((_) async => []);

      //When
      final response = await voteCountRepository.getMovieList();

      //Then
      verify(apiService.getMovieList()).called(1);
      verify(movieDao.getMovies()).called(1);
      expect(response.data, null);
      expect(response.error, null);
      assert(response is DataEmpty<MovieListEntity>);
    });

    test('getMovieList() should get the failed state', () async {
      //Given
      final exception = Exception();
      when(
        apiService.getMovieList(),
      ).thenAnswer((_) async => failedDataStateMock);
      when(movieDao.getMovies()).thenThrow(exception);

      //When
      final response = await voteCountRepository.getMovieList();

      //Then
      verify(apiService.getMovieList()).called(1);
      verify(movieDao.getMovies()).called(1);
      expect(response.data, null);
      expect(
        response.error,
        '${StringConstants.errorMessage}${exception.toString()}',
      );
      assert(response is DataFailed<MovieListEntity>);
    });
  });
}
