import 'package:flutter/material.dart';

import '../util/route_constants.dart';
import '../view/default_page.dart';
import '../view/home_page.dart';

class AppRoutes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteConstants.homeRoute:
        return MaterialPageRoute(builder: (_) => HomePage());
      default:
        return MaterialPageRoute(builder: (_) => const DefaultPage());
    }
  }
}
