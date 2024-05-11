import 'package:core/common/assets_manager.dart';
import 'package:core/common/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 30.h,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 200.h,
              padding: EdgeInsets.only(bottom: 24.h),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    AssetsManager.logoImage,
                    package: "core",
                  ),
                ),
              ),
            ),
            Text(
              "Selamat Datang Di Edukita",
              style: primaryTextStyle.copyWith(
                fontSize: 24.sp,
                fontWeight: bold,
              ),
            ),
            Text(
              "Aplikasi Quiz Soal SNBT",
              style: secondaryTextStyle.copyWith(
                fontSize: 18.sp,
                fontWeight: bold,
              ),
            ),
            const Spacer(),
            InkWell(
              onTap: () {},
              child: Image.asset(
                width: MediaQuery.of(context).size.width * 0.8,
                AssetsManager.googleLogin,
                package: 'core',
              ),
            ),
            SizedBox(
              height: 100.h,
            )
          ],
        ),
      ),
    );
  }
}
