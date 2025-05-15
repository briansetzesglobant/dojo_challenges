import 'package:flutter_test/flutter_test.dart';

import '../../../../mock_data/mock_data.dart';

void main() {
  group('MovieListEntity test', () {
    test('copyWith() should clone the movies list', () async {
      //Given

      //When
      final movieListEntity = movieListMock.copyWith(page: 2);

      //Then
      expect(movieListEntity.page, 2);
    });

    test('MovieListEntity should be iterable', () async {
      //Given

      //When
      for (var movieEntity in movieListMock) {
        //Then
        expect(movieEntity.title, 'title');
      }
    });
  });
}
