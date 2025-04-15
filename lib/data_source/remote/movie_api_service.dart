import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';

import '../../env/env.dart';
import '../../model/movie_list.dart';
import '../../util/api_service_constants.dart';
import '../../util/string_constants.dart';

class MovieApiService {
  Client client = Client();

  Future<MovieList> getMovieList() async {
    try {
      final response = await client.get(
        Uri.parse(
          '${ApiServiceConstants.uri}${ApiServiceConstants.endpointTopRatedMovies}${ApiServiceConstants.apiKeyParameter}${Env.movieApiKey}',
        ),
      );
      if (response.statusCode == HttpStatus.ok) {
        return MovieList.fromJson(json.decode(response.body));
      } else {
        throw Exception(StringConstants.errorMessage);
      }
    } catch (e) {
      throw Exception(StringConstants.errorMessage);
    }
  }
}
