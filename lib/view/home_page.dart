import 'package:dojo_challenges/util/asset_constants.dart';
import 'package:dojo_challenges/util/color_constants.dart';
import 'package:flutter/material.dart';

import '../model/movie_list.dart';
import '../repository/repository.dart';
import '../resource/data_state.dart';
import '../util/api_service_constants.dart';
import '../util/string_constants.dart';
import '../widget/movie_card.dart';
import '../widget/unsuccess.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.repository});

  final Repository repository;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(StringConstants.homePageTitle)),
      body: SafeArea(
        child: FutureBuilder<DataState<MovieList>>(
          future: repository.getMovieList(),
          builder: (context, AsyncSnapshot<DataState<MovieList>> snapshot) {
            if (snapshot.hasData) {
              switch (snapshot.data!.type) {
                case DataStateType.success:
                  return ListView.builder(
                    itemCount: snapshot.data!.data!.results.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        title: MovieCard(
                          title: snapshot.data!.data!.results[index].title,
                          image:
                              '${ApiServiceConstants.imageNetwork}${snapshot.data!.data!.results[index].posterPath}',
                        ),
                      );
                    },
                  );
                case DataStateType.empty:
                  return Unsuccess(
                    text: StringConstants.homePageEmptyMessage,
                    image: AssetConstants.homePageEmptyImage,
                  );
                case DataStateType.error:
                  return Unsuccess(
                    text: snapshot.data!.error!,
                    image: AssetConstants.homePageErrorImage,
                  );
              }
            }
            return const Center(
              child: CircularProgressIndicator(
                color: ColorConstants.appThemeColor,
              ),
            );
          },
        ),
      ),
    );
  }
}
