import 'package:dojo_challenges/src/data/data_source/local/data_base/data_base.dart';
import 'package:dojo_challenges/src/domain/data_base/data_base_interface.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'data_base_test.mocks.dart';

@GenerateMocks([Database])
void main() {
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;
  late DataBaseInterface dataBase;
  late Database dataBaseMock;

  setUp(() {
    dataBase = DataBase.instance;
    dataBaseMock = MockDatabase();
  });

  group('DataBase test', () {
    test('openDataBase() should open the data base', () async {
      //Given

      //When
      await dataBase.openDataBase();
      final movieDao = dataBase.movieDao;

      //Then
      expect((dataBase as DataBase).testDataBase, isNotNull);
      expect(movieDao, isNotNull);
    });

    test('closeDataBase() should close the data base', () async {
      //Given
      (dataBase as DataBase).testDataBase = dataBaseMock;
      when(dataBaseMock.close()).thenAnswer((_) async => Future.value());

      //When
      await dataBase.closeDataBase();
      final movieDao = dataBase.movieDao;

      //Then
      verify(dataBaseMock.close()).called(1);
      expect(movieDao, isNotNull);
    });
  });
}
