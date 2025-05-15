import 'package:dojo_challenges/src/data/model/movie_list.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../mock_data/mock_data.dart';

void main() {
  group('MovieList test', () {
    test('fromJson() should transform the json to movie list', () async {
      //Given

      //When
      final movieList = MovieList.fromJson(movieListJsonMock);

      //Then
      expect(movieList.results.first.title, movieListMock.results.first.title);
    });
  });
}
