import 'package:core/common/assets_manager.dart';
import 'package:core/common/styles.dart';
import 'package:core/router/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home/domain/entities/learning_topic.dart';
import 'package:shimmer/shimmer.dart';

class LearningTopicGridWidget extends StatelessWidget {
  final LearningTopic learningTopic;
  const LearningTopicGridWidget({
    super.key,
    required this.learningTopic,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 157.5.w,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 4,
            offset: const Offset(0, 3),
          )
        ],
        borderRadius: BorderRadius.circular(
          12.r,
        ),
      ),
      child: Material(
        borderRadius: BorderRadius.circular(12.r),
        clipBehavior: Clip.hardEdge,
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(context, AppRoutes.questionScreen, arguments: {
              'learningTopicID': learningTopic.id,
            });
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                AssetsManager.getIcon(learningTopic.icon),
                package: "core",
                width: 110.w,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 110.w,
                    height: 110.w, // Adjust as per your design
                    color: Colors.grey.withOpacity(0.1), // Placeholder color
                    child: const Icon(Icons.error, color: Colors.red),
                  );
                },
              ),
              SizedBox(
                height: 18.h,
              ),
              Text(
                learningTopic.name,
                style: primaryTextStyle.copyWith(
                  fontWeight: bold,
                ),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class LearningTopicGridSkeleton extends StatelessWidget {
  const LearningTopicGridSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 157.5.w,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 4,
            offset: const Offset(0, 3),
          )
        ],
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Container(
          padding: EdgeInsets.all(8.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 110.w,
                height: 110.w,
                color: Colors.white,
              ),
              SizedBox(height: 18.h),
              Container(
                width: 80.w,
                height: 20.h,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
