import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';

import '../../env/env.dart';
import '../../model/movie_list.dart';
import '../../resource/data_state.dart';
import '../../util/api_service_constants.dart';
import '../../util/string_constants.dart';

class ApiService {
  Client client = Client();

  Future<DataState<MovieList>> getMovieList() async {
    try {
      final response = await client.get(
        Uri.parse(
          '${ApiServiceConstants.uri}${ApiServiceConstants.endpointTopRatedMovies}${ApiServiceConstants.apiKeyParameter}${Env.movieApiKey}',
        ),
      );
      if (response.statusCode == HttpStatus.ok) {
        MovieList movieList = MovieList.fromJson(json.decode(response.body));
        if (movieList.results.isNotEmpty) {
          return DataSuccess(movieList);
        } else {
          return const DataEmpty();
        }
      } else {
        return DataFailed(
          '${StringConstants.errorMessage}: ${response.statusCode}',
        );
      }
    } catch (exception) {
      return DataFailed(
        '${StringConstants.errorMessage}: ${exception.toString()}',
      );
    }
  }
}
