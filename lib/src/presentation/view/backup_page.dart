import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/util/api_service_constants.dart';
import '../../core/util/asset_constants.dart';
import '../../core/util/color_constants.dart';
import '../../core/util/string_constants.dart';
import '../../di/provider/provider.dart';
import '../widget/movie_card.dart';
import '../widget/movie_scaffold.dart';
import '../widget/unsuccess.dart';

class BackupPage extends ConsumerWidget {
  const BackupPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(getBackupContentProvider);
    return provider.when(
      data:
          (data) =>
              data.isNotEmpty
                  ? MovieScaffold(
                    title: StringConstants.backupPageTitle,
                    child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          title: MovieCard(
                            title: data[index].title,
                            image:
                                '${ApiServiceConstants.imageNetwork}${data[index].posterPath}',
                          ),
                        );
                      },
                    ),
                  )
                  : Unsuccess(
                    text: StringConstants.homePageEmptyMessage,
                    image: AssetConstants.homePageEmpty,
                  ),
      error:
          (exception, _) => Unsuccess(
            text: '${StringConstants.errorMessage}${exception.toString()}',
            image: AssetConstants.homePageError,
          ),
      loading:
          () => MovieScaffold(
            child: Center(
              child: CircularProgressIndicator(
                color: ColorConstants.appThemeColor,
              ),
            ),
          ),
    );
  }
}
