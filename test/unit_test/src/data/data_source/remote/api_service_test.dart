import 'dart:io';

import 'package:dojo_challenges/env/env.dart';
import 'package:dojo_challenges/src/core/resource/data_state.dart';
import 'package:dojo_challenges/src/core/util/api_service_constants.dart';
import 'package:dojo_challenges/src/core/util/string_constants.dart';
import 'package:dojo_challenges/src/data/data_source/remote/api_service/api_service.dart';
import 'package:dojo_challenges/src/domain/api_service/api_service_interface.dart';
import 'package:dojo_challenges/src/domain/entity/movie_list_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../../mock_data/mock_data.dart';
import 'api_service_test.mocks.dart';

@GenerateMocks([Client])
void main() {
  late ApiServiceInterface apiService;
  late Client client;

  setUp(() {
    client = MockClient();
    apiService = ApiService(client: client);
  });

  group('ApiService test', () {
    test('getMovieList() should get the success state', () async {
      //Given
      when(
        client.get(
          Uri.parse(
            '${ApiServiceConstants.uri}${ApiServiceConstants.endpointTopRatedMovies}${ApiServiceConstants.apiKeyParameter}${Env.movieApiKey}',
          ),
        ),
      ).thenAnswer(
        (_) async => Response(successMovieListJsonStringMock, HttpStatus.ok),
      );

      //When
      final response = await apiService.getMovieList();

      //Then
      verify(
        client.get(
          Uri.parse(
            '${ApiServiceConstants.uri}${ApiServiceConstants.endpointTopRatedMovies}${ApiServiceConstants.apiKeyParameter}${Env.movieApiKey}',
          ),
        ),
      ).called(1);
      expect(
        response.data!.results.first.title,
        movieListMock.results.first.title,
      );
      expect(response.error, null);
      assert(response is DataSuccess<MovieListEntity>);
    });

    test('getMovieList() should get the empty state', () async {
      //Given
      when(
        client.get(
          Uri.parse(
            '${ApiServiceConstants.uri}${ApiServiceConstants.endpointTopRatedMovies}${ApiServiceConstants.apiKeyParameter}${Env.movieApiKey}',
          ),
        ),
      ).thenAnswer(
        (_) async => Response(emptyMovieListJsonStringMock, HttpStatus.ok),
      );

      //When
      final response = await apiService.getMovieList();

      //Then
      verify(
        client.get(
          Uri.parse(
            '${ApiServiceConstants.uri}${ApiServiceConstants.endpointTopRatedMovies}${ApiServiceConstants.apiKeyParameter}${Env.movieApiKey}',
          ),
        ),
      ).called(1);
      expect(response.data, null);
      expect(response.error, null);
      assert(response is DataEmpty<MovieListEntity>);
    });

    test('getMovieList() should get the failed state', () async {
      //Given
      when(
        client.get(
          Uri.parse(
            '${ApiServiceConstants.uri}${ApiServiceConstants.endpointTopRatedMovies}${ApiServiceConstants.apiKeyParameter}${Env.movieApiKey}',
          ),
        ),
      ).thenAnswer(
        (_) async =>
            Response(failedMovieListJsonStringMock, HttpStatus.notFound),
      );

      //When
      final response = await apiService.getMovieList();

      //Then
      verify(
        client.get(
          Uri.parse(
            '${ApiServiceConstants.uri}${ApiServiceConstants.endpointTopRatedMovies}${ApiServiceConstants.apiKeyParameter}${Env.movieApiKey}',
          ),
        ),
      ).called(1);
      expect(response.data, null);
      expect(
        response.error,
        '${StringConstants.errorMessage}${HttpStatus.notFound}',
      );
      assert(response is DataFailed<MovieListEntity>);
    });

    test('getMovieList() should generate a exception', () async {
      //Given
      final exception = Exception();
      when(
        client.get(
          Uri.parse(
            '${ApiServiceConstants.uri}${ApiServiceConstants.endpointTopRatedMovies}${ApiServiceConstants.apiKeyParameter}${Env.movieApiKey}',
          ),
        ),
      ).thenThrow(exception);

      //When
      final response = await apiService.getMovieList();

      //Then
      verify(
        client.get(
          Uri.parse(
            '${ApiServiceConstants.uri}${ApiServiceConstants.endpointTopRatedMovies}${ApiServiceConstants.apiKeyParameter}${Env.movieApiKey}',
          ),
        ),
      ).called(1);
      expect(response.data, null);
      expect(
        response.error,
        '${StringConstants.errorMessage}${exception.toString()}',
      );
      assert(response is DataFailed<MovieListEntity>);
    });
  });
}
