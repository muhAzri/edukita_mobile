import 'package:core/common/styles.dart';
import 'package:core/router/app_router.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      designSize: const Size(375, 812),
      builder: (context, child) {
        return MaterialApp(
          theme: ThemeData(
            appBarTheme: AppBarTheme(
              color: accentColor,
              iconTheme: IconThemeData(
                color: backgroundColor,
              ),
              centerTitle: true,
              titleTextStyle: whiteTextStyle.copyWith(
                fontSize: 24.sp,
              ),
            ),
          ),
          navigatorKey: navigatorKey,
          debugShowCheckedModeBanner: kDebugMode,
          onGenerateRoute: AppRouter.onGenerateRoute,
        );
      },
    );
  }
}
