import 'package:auth/bloc/login/login_bloc.dart';
import 'package:auth/presentation/screens/login_screen.dart';
import 'package:core/presentation/screens/main_screen.dart';
import 'package:core/presentation/screens/splash_screen.dart';
import 'package:core/router/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:core/injector.dart' as di;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:question/presentation/screens/question_screen.dart';

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
                return BlocProvider(
                  create: (context) => di.locator<LoginBloc>(),
                  child: const LoginScreen(),
                );

              case AppRoutes.mainScreen:
                return const MainScreen();

              case AppRoutes.questionScreen:
                final args = settings.arguments as Map<String, dynamic>;

                final String learningTopicID = args['learningTopicID'];

                return QuestionScreen(
                  learningTopicID: learningTopicID,
                );

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
