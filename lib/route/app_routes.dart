import 'package:flutter/material.dart';

import '../data_source/local/data_base/data_base.dart';
import '../data_source/remote/api_service/api_service.dart';
import '../repository/repository.dart';
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
