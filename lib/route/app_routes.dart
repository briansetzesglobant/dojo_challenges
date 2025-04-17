import 'package:dojo_challenges/data_source/local/data_base.dart';
import 'package:dojo_challenges/repository/repository.dart';
import 'package:flutter/material.dart';

import '../data_source/remote/api_service.dart';
import '../util/route_constants.dart';
import '../view/default_page.dart';
import '../view/home_page.dart';

class AppRoutes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteConstants.homeRoute:
        return MaterialPageRoute(
          builder:
              (_) => HomePage(
                repository: Repository(
                  apiService: ApiService(),
                  dataBase: DataBase.instance,
                ),
              ),
        );
      default:
        return MaterialPageRoute(builder: (_) => const DefaultPage());
    }
  }
}
