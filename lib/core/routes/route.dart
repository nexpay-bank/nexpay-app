import 'package:flutter/material.dart';
import 'package:nexpay/core/routes/route_name.dart';
import 'package:nexpay/features/auth/presentation/pages/login_page.dart';
import 'package:nexpay/features/auth/presentation/pages/register_page.dart';
import 'package:nexpay/features/navigation/pages/navigation_page.dart';
import 'package:nexpay/features/onboarding/presentation/pages/onboarding_page.dart';
import 'package:nexpay/features/transfer/presentation/pages/transfer_page.dart';

class AppRoute {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();
  static Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case RouteName.login:
        return _materialPageRoute(const LoginPage());
      case RouteName.register:
        return _materialPageRoute(const RegisterPage());
      case RouteName.home:
        return _materialPageRoute(const NavigationPage());
      case RouteName.onboarding:
        return _materialPageRoute(const OnboardingPage());
      case RouteName.transfer:
        return _materialPageRoute(const TransferPage());
      default:
        return _materialPageRoute(const OnboardingPage());
    }
  }

  static _materialPageRoute(Widget widget) {
    return MaterialPageRoute(builder: (context) => widget);
  }
}
