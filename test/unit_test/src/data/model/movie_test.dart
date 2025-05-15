import 'package:dojo_challenges/src/data/model/movie.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../mock_data/mock_data.dart';

void main() {
  group('Movie test', () {
    test('fromJson() should transform the json to movie', () async {
      //Given

      //When
      final movie = Movie.fromJson(movieJsonMock);

      //Then
      expect(movie.title, movieMock.title);
    });

    test('toJson() should transform the movie to json', () async {
      //Given

      //When
      final movieJson = movieMock.toJson();

      //Then
      expect(movieJson, movieJsonMock);
    });
  });
}
