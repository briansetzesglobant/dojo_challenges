import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'src/config/route/app_routes.dart';
import 'src/config/theme/app_themes.dart';
import 'src/core/util/route_constants.dart';

void main() {
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppThemes.appTheme,
      initialRoute: RouteConstants.homeRoute,
      onGenerateRoute: AppRoutes.generateRoute,
    );
  }
}
