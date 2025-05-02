import 'package:flutter/material.dart';

import '../../core/resource/data_state.dart';
import '../../core/util/asset_constants.dart';
import '../../core/util/string_constants.dart';
import '../../domain/entity/movie_list_entity.dart';
import 'success.dart';
import 'unsuccess.dart';

class DataWidget extends StatelessWidget {
  const DataWidget({super.key, required this.data, required this.callback});

  final DataState<MovieListEntity> data;
  final VoidCallback callback;

  @override
  Widget build(BuildContext context) {
    switch (data.type) {
      case DataStateType.success:
        return Success(movies: data.data!.results, callback: callback);
      case DataStateType.empty:
        return Unsuccess(
          text: StringConstants.homePageEmptyMessage,
          image: AssetConstants.homePageEmpty,
        );
      case DataStateType.error:
        return Unsuccess(
          text: data.error!,
          image: AssetConstants.homePageError,
        );
    }
  }
}
