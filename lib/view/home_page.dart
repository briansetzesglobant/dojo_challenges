import 'package:dojo_challenges/util/color_constants.dart';
import 'package:flutter/material.dart';

import '../data_source/remote/movie_api_service.dart';
import '../model/movie_list.dart';
import '../util/api_service_constants.dart';
import '../util/string_constants.dart';
import '../util/text_style_constants.dart';
import '../widget/movie_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.movieApiService});

  final MovieApiService movieApiService;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(StringConstants.homePageTitle)),
      body: SafeArea(
        child: FutureBuilder(
          future: movieApiService.getMovieList(),
          builder: (context, AsyncSnapshot<MovieList> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data?.results.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: MovieCard(
                      title: snapshot.data!.results[index].title,
                      image:
                          '${ApiServiceConstants.imageNetwork}${snapshot.data!.results[index].posterPath}',
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(
                  StringConstants.errorMessage,
                  style: TextStyleConstants.homePageErrorMessageTextStyle,
                  textAlign: TextAlign.center,
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(
                  color: ColorConstants.appThemeColor,
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
