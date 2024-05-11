import 'package:auth/presentation/screens/login_screen.dart';
import 'package:core/presentation/screens/splash_screen.dart';
import 'package:core/router/app_routes.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static Route? onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute(
      settings: settings,
      builder: (context) {
        return Builder(
          builder: (BuildContext context) {
            switch (settings.name) {
              case AppRoutes.splashScreen:
                return const SplashScreen();

              case AppRoutes.loginScreen:
                return const LoginScreen();

              default:
                return const NamedRouteNotFound();
            }
          },
        );
      },
    );
  }
}

class NamedRouteNotFound extends StatelessWidget {
  const NamedRouteNotFound({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Check Named Route',
          style: TextStyle(fontSize: 30, color: Colors.black),
        ),
      ),
    );
  }
}
