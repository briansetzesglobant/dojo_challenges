import 'package:dojo_challenges/route/app_routes.dart';
import 'package:dojo_challenges/util/route_constants.dart';
import 'package:flutter/material.dart';

import 'util/color_constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(color: ColorConstants.appThemeColor),
      ),
      initialRoute: RouteConstants.homeRoute,
      onGenerateRoute: AppRoutes.generateRoute,
    );
  }
}
