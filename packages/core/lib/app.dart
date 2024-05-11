import 'package:core/router/app_router.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const ScreenUtilInit(
      minTextAdapt: true,
      designSize: Size(375, 812),
      child: MaterialApp(
        debugShowCheckedModeBanner: kDebugMode,
        onGenerateRoute: AppRouter.onGenerateRoute,
      ),
    );
  }
}
