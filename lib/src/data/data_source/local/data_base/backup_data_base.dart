import 'package:firebase_database/firebase_database.dart';

import '../../../../core/util/backup_data_base_constants.dart';
import '../../../../domain/entity/movie_entity.dart';
import '../../../model/movie.dart';

class BackupDataBase {
  BackupDataBase._privateConstructor();

  static final BackupDataBase instance = BackupDataBase._privateConstructor();

  static final FirebaseDatabase _instanceRealtime = FirebaseDatabase.instance;

  static final DatabaseReference _movieTable = _instanceRealtime.ref().child(
    BackupDataBaseConstants.tableName,
  );

  Future<void> dropBackup() async => await _movieTable.remove();

  Future<void> makeABackup(List<MovieEntity> movies) async {
    for (final movie in movies) {
      await _movieTable.push().set(
        Movie(
          adult: movie.adult,
          backdropPath: movie.backdropPath,
          genreIds: movie.genreIds,
          id: movie.id,
          originalLanguage: movie.originalLanguage,
          originalTitle: movie.originalTitle,
          overview: movie.overview,
          popularity: movie.popularity,
          posterPath: movie.posterPath,
          releaseDate: movie.releaseDate,
          title: movie.title,
          video: movie.video,
          voteAverage: movie.voteAverage,
          voteCount: movie.voteCount,
        ).toJson(),
      );
    }
  }

  Future<List<MovieEntity>> getBackupContent() async {
    List<MovieEntity> moviesList = [];
    DataSnapshot dataSnapshotMovie = await _movieTable.get();
    if (dataSnapshotMovie.exists) {
      moviesList.addAll(
        dataSnapshotMovie.children.map(
          (movie) =>
              Movie.fromJson(Map<String, dynamic>.from(movie.value as Map)),
        ),
      );
    }
    return moviesList;
  }
}
