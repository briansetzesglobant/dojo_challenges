import 'dart:convert';

import 'package:sqflite/sqflite.dart';

import '../../../../core/util/data_base_constants.dart';
import '../../../../domain/entity/movie_entity.dart';
import '../../../model/movie.dart';

class MovieDao {
  MovieDao({required this.dataBase});

  final Database dataBase;

  Future<void> deleteMovies() async {
    await dataBase.delete(DataBaseConstants.tableName);
  }

  Future<void> insertMovies(List<MovieEntity> movies) async {
    for (var movie in movies) {
      final movieJson = (movie as Movie).toJson();
      movieJson['adult'] = movieJson['adult'] ? 1 : 0;
      movieJson['genre_ids'] = json.encode(movieJson['genre_ids']);
      movieJson['video'] = movieJson['video'] ? 1 : 0;
      await dataBase.insert(DataBaseConstants.tableName, movieJson);
    }
  }

  Future<List<MovieEntity>> getMovies() async {
    List<Map<String, dynamic>> movieJsons = await dataBase.query(
      DataBaseConstants.tableName,
    );
    return movieJsons.map((movieJson) {
      final mutableMovieJson = Map.of(movieJson);
      mutableMovieJson['adult'] = movieJson['adult'] == 1;
      mutableMovieJson['genre_ids'] = json.decode(movieJson['genre_ids']);
      mutableMovieJson['video'] = movieJson['video'] == 1;
      return Movie.fromJson(mutableMovieJson);
    }).toList();
  }
}
