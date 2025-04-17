import 'dart:convert';

import 'package:dojo_challenges/util/data_base_constants.dart';
import 'package:sqflite/sqflite.dart';

import '../../model/movie.dart';

class DataBase {
  DataBase._privateConstructor();

  static final DataBase instance = DataBase._privateConstructor();

  late Database _database;

  Future<void> openDataBase() async {
    _database = await openDatabase(
      DataBaseConstants.dataBaseName,
      onCreate: (Database db, int version) async {
        return await db.execute('''CREATE TABLE ${DataBaseConstants.tableName} (
              adult INTEGER NOT NULL,
              backdrop_path TEXT NOT NULL,
              genre_ids TEXT NOT NULL,
              id INTEGER PRIMARY KEY,
              original_language TEXT NOT NULL,
              original_title TEXT NOT NULL,
              overview TEXT NOT NULL,
              popularity REAL NOT NULL,
              poster_path TEXT NOT NULL,
              release_date TEXT NOT NULL,
              title TEXT NOT NULL,
              video INTEGER NOT NULL,
              vote_average REAL NOT NULL,
              vote_count INTEGER NOT NULL
        )''');
      },
      version: 1,
    );
  }

  Future<void> closeDataBase() async {
    await _database.close();
  }

  Future<void> deleteMovies() async {
    await _database.delete(DataBaseConstants.tableName);
  }

  Future<void> insertMovies(List<Movie> movies) async {
    for (var movie in movies) {
      var movieJson = movie.toJson();
      movieJson['adult'] = movieJson['adult'] ? 1 : 0;
      movieJson['genre_ids'] = json.encode(movieJson['genre_ids']);
      movieJson['video'] = movieJson['video'] ? 1 : 0;
      await _database.insert(DataBaseConstants.tableName, movieJson);
    }
  }

  Future<List<Movie>> getMovies() async {
    List<Map<String, dynamic>> movies = await _database.query(
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
