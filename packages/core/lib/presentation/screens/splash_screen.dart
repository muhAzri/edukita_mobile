import 'dart:async';

import 'package:core/common/assets_manager.dart';
import 'package:core/common/styles.dart';
import 'package:core/router/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:core/injector.dart' as di;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    navigateToLogin();
    super.initState();
  }

  void navigateToLogin() {
    Timer(
      const Duration(
        seconds: 3,
      ),
      () async {
        final FlutterSecureStorage storage = di.locator<FlutterSecureStorage>();
        final token = await storage.read(key: "access_token");
        if (mounted) {
          if (token != null) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              AppRoutes.mainScreen,
              (route) => false,
            );
          } else {
            Navigator.pushNamedAndRemoveUntil(
              context,
              AppRoutes.loginScreen,
              (route) => false,
            );
          }
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Center(
        child: Image.asset(
          AssetsManager.logoImage,
          package: "core",
        ),
      ),
    );
  }
}
