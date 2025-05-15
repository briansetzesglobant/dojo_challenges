import 'package:dojo_challenges/src/core/util/data_base_constants.dart';
import 'package:dojo_challenges/src/data/data_source/local/DAOs/movie_dao.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:sqflite/sqflite.dart';

import '../../../../../../mock_data/mock_data.dart';
import 'movie_dao_test.mocks.dart';

@GenerateMocks([Database])
void main() {
  late MovieDao movieDao;
  late Database dataBase;

  setUp(() {
    dataBase = MockDatabase();
    movieDao = MovieDao(dataBase: dataBase);
  });

  group('MovieDao test', () {
    test('deleteMovies() should delete the movies', () async {
      //Given
      when(
        dataBase.delete(DataBaseConstants.tableName),
      ).thenAnswer((_) async => 0);

      //When
      await movieDao.deleteMovies();

      //Then
      verify(dataBase.delete(DataBaseConstants.tableName)).called(1);
    });

    test('insertMovies() should insert the movies', () async {
      //Given
      when(
        dataBase.insert(DataBaseConstants.tableName, dataBaseMovieJsonMock),
      ).thenAnswer((_) async => 1);

      //When
      await movieDao.insertMovies([movieMock]);

      //Then
      verify(
        dataBase.insert(DataBaseConstants.tableName, dataBaseMovieJsonMock),
      ).called(1);
    });

    test('getMovies() should get the movies', () async {
      //Given
      when(
        dataBase.query(DataBaseConstants.tableName),
      ).thenAnswer((_) async => [dataBaseMovieJsonMock]);

      //When
      final movies = await movieDao.getMovies();

      //Then
      verify(dataBase.query(DataBaseConstants.tableName)).called(1);
      expect(movies.first.title, movieMock.title);
    });
  });
}
