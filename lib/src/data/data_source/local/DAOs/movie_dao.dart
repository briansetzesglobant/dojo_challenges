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
      var movieJson = (movie as Movie).toJson();
      movieJson['adult'] = movieJson['adult'] ? 1 : 0;
      movieJson['genre_ids'] = json.encode(movieJson['genre_ids']);
      movieJson['video'] = movieJson['video'] ? 1 : 0;
      await dataBase.insert(DataBaseConstants.tableName, movieJson);
    }
  }

  Future<List<MovieEntity>> getMovies() async {
    List<Map<String, dynamic>> movies = await dataBase.query(
      DataBaseConstants.tableName,
    );
    return movies.map((movie) {
      final mutableMovie = Map.of(movie);
      mutableMovie['adult'] = movie['adult'] == 1;
      mutableMovie['genre_ids'] = json.decode(movie['genre_ids']);
      mutableMovie['video'] = movie['video'] == 1;
      return Movie.fromJson(mutableMovie);
    }).toList();
  }
}
