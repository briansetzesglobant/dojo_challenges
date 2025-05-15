import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/util/asset_constants.dart';
import '../../core/util/string_constants.dart';
import '../provider/provider.dart';
import '../widget/data_widget.dart';
import '../widget/splash_screen.dart';
import '../widget/unsuccess.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  var isOriginalRepository = true;

  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(movieProvider(isOriginalRepository));
    return provider.when(
      data:
          (data) => DataWidget(
            data: data,
            callback: () {
              setState(() {
                isOriginalRepository = false;
              });
            },
          ),
      error:
          (exception, _) => Unsuccess(
            text: '${StringConstants.errorMessage}${exception.toString()}',
            image: AssetConstants.homePageError,
          ),
      loading: () => SplashScreen(),
    );
  }
}
