import 'package:dojo_challenges/src/core/resource/data_state.dart';
import 'package:dojo_challenges/src/data/model/movie.dart';
import 'package:dojo_challenges/src/data/model/movie_list.dart';
import 'package:dojo_challenges/src/domain/entity/movie_list_entity.dart';

const successMovieListJsonStringMock = '''{
      "page": 1,
      "results": [
        {
          "adult": true,
          "backdrop_path": "backdrop_path",
          "genre_ids": [1,2,3],
          "id": 1,
          "original_language": "original_language",
          "original_title": "original_title",
          "overview": "overview",
          "popularity": 1.0,
          "poster_path": "poster_path",
          "release_date": "release_date",
          "title": "title",
          "video": true,
          "vote_average": 1.0,
          "vote_count": 1
        }
      ],
      "total_pages": 1,
      "total_results": 1
    }''';

const emptyMovieListJsonStringMock = '''{
      "page": 1,
      "results": [],
      "total_pages": 1,
      "total_results": 1
    }''';

const failedMovieListJsonStringMock = '''{
      "error": [],
    }''';

const movieJsonMock = {
  "adult": true,
  "backdrop_path": "backdrop_path",
  "genre_ids": [1, 2, 3],
  "id": 1,
  "original_language": "original_language",
  "original_title": "original_title",
  "overview": "overview",
  "popularity": 1.0,
  "poster_path": "poster_path",
  "release_date": "release_date",
  "title": "title",
  "video": true,
  "vote_average": 1.0,
  "vote_count": 1,
};

const movieListJsonMock = {
  "page": 1,
  "results": [movieJsonMock],
  "total_pages": 1,
  "total_results": 1,
};

final dataBaseMovieJsonMock = () {
  final dataBaseMovieJsonAux = Map.of(movieJsonMock);
  dataBaseMovieJsonAux['adult'] = 1;
  dataBaseMovieJsonAux['genre_ids'] = "[1,2,3]";
  dataBaseMovieJsonAux['video'] = 1;
  return dataBaseMovieJsonAux;
}();

final movieMock = Movie(
  adult: true,
  backdropPath: "backdrop_path",
  genreIds: [1, 2, 3],
  id: 1,
  originalLanguage: "original_language",
  originalTitle: "original_title",
  overview: "overview",
  popularity: 1.0,
  posterPath: "poster_path",
  releaseDate: "release_date",
  title: "title",
  video: true,
  voteAverage: 1.0,
  voteCount: 1,
);

final voteCountMovieMock = Movie(
  adult: true,
  backdropPath: "backdrop_path",
  genreIds: [1, 2, 3],
  id: 1,
  originalLanguage: "original_language",
  originalTitle: "original_title",
  overview: "overview",
  popularity: 1.0,
  posterPath: "poster_path",
  releaseDate: "release_date",
  title: "title",
  video: true,
  voteAverage: 1.0,
  voteCount: 20000,
);

final movieListMock = MovieList(
  page: 1,
  results: [movieMock, voteCountMovieMock],
  totalPages: 1,
  totalResults: 1,
);

final voteCountMovieListMock = MovieList(
  page: 1,
  results: [voteCountMovieMock],
  totalPages: 1,
  totalResults: 1,
);

final successDataStateMock = DataSuccess(movieListMock);

final voteCountSuccessDataStateMock = DataSuccess(voteCountMovieListMock);

const emptyDataStateMock = DataEmpty<MovieListEntity>();

const failedDataStateMock = DataFailed<MovieListEntity>('error');
