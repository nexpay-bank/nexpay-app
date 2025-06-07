import 'package:flutter/material.dart';
import 'package:nexpay/core/routes/route_name.dart';

class AppRoute {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();
  static Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case RouteName.authPage:
        return _materialPageRoute(const AuthPage());
      case RouteName.mainPage:
        return _materialPageRoute(MainPage());
      default:
        return _materialPageRoute(MainPage());
    }
  }

  static _materialPageRoute(Widget widget) {
    return MaterialPageRoute(builder: (context) => widget);
  }
}
