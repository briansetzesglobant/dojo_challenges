import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';

import '../../../../../env/env.dart';
import '../../../../core/resource/data_state.dart';
import '../../../../core/util/api_service_constants.dart';
import '../../../../core/util/string_constants.dart';
import '../../../../domain/api_service/api_service_interface.dart';
import '../../../../domain/entity/movie_list_entity.dart';
import '../../../model/movie_list.dart';

class ApiService implements ApiServiceInterface {
  ApiService({required this.client});

  final Client client;

  @override
  Future<DataState<MovieListEntity>> getMovieList() async {
    try {
      final response = await client.get(
        Uri.parse(
          '${ApiServiceConstants.uri}${ApiServiceConstants.endpointTopRatedMovies}${ApiServiceConstants.apiKeyParameter}${Env.movieApiKey}',
        ),
      );
      if (response.statusCode == HttpStatus.ok) {
        MovieListEntity movieList = MovieList.fromJson(
          json.decode(response.body),
        );
        if (movieList.results.isNotEmpty) {
          return DataSuccess(movieList);
        } else {
          return const DataEmpty();
        }
      } else {
        return DataFailed(
          '${StringConstants.errorMessage}${response.statusCode}',
        );
      }
    } catch (exception) {
      return DataFailed(
        '${StringConstants.errorMessage}${exception.toString()}',
      );
    }
  }
}
