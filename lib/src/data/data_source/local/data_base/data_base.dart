import 'package:sqflite/sqflite.dart';

import '../../../../core/util/data_base_constants.dart';
import '../../../../domain/data_base/data_base_interface.dart';
import '../DAOs/movie_dao.dart';

class DataBase implements DataBaseInterface {
  DataBase._privateConstructor();

  static final DataBase instance = DataBase._privateConstructor();

  late Database _dataBase;

  @override
  MovieDao get movieDao => MovieDao(dataBase: _dataBase);

  @override
  Future<void> openDataBase() async {
    _dataBase = await openDatabase(
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

  @override
  Future<void> closeDataBase() async {
    await _dataBase.close();
  }
}
