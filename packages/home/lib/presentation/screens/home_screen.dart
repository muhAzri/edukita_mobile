import 'package:core/common/assets_manager.dart';
import 'package:core/common/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home/bloc/bloc/short_profile_bloc.dart';
import 'package:home/bloc/learning_topic/learning_topic_bloc.dart';
import 'package:home/presentation/widgets/learning_topic_widget.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends StatelessWidget {
  final LearningTopicBloc learningTopicBloc;
  final ShortProfileBloc shortProfileBloc;

  const HomeScreen({
    super.key,
    required this.learningTopicBloc,
    required this.shortProfileBloc,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const EduKitaBrandLine(),
                WelcomeWidget(
                  shortProfileBloc: shortProfileBloc,
                ),
                LearningTopicsGrid(
                  learningTopicBloc: learningTopicBloc,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class EduKitaBrandLine extends StatelessWidget {
  const EduKitaBrandLine({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          AssetsManager.logoImage,
          package: 'core',
          width: 64.w,
        ),
        SizedBox(
          width: 8.w,
        ),
        Text(
          "Edukita",
          style: primaryTextStyle.copyWith(fontWeight: bold, fontSize: 24.sp),
        )
      ],
    );
  }
}

class WelcomeWidget extends StatelessWidget {
  final ShortProfileBloc shortProfileBloc;

  const WelcomeWidget({
    super.key,
    required this.shortProfileBloc,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => shortProfileBloc..add(GetShortProfileEvent()),
      child: BlocBuilder<ShortProfileBloc, ShortProfileState>(
        builder: (context, state) {
          if (state is ShortProfileLoaded) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: 60.h,
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: RichText(
                    text: TextSpan(
                      style: primaryTextStyle.copyWith(
                        fontSize: 16.sp,
                      ),
                      children: [
                        TextSpan(
                          text: "👋 ",
                          style: primaryTextStyle.copyWith(
                            fontSize: 24.sp,
                          ),
                        ),
                        const TextSpan(
                          text: "Hai, ",
                        ),
                        TextSpan(
                          text: state.shortProfile.name,
                          style: primaryTextStyle.copyWith(
                            color: secondaryColor,
                            fontSize: 18.sp,
                          ),
                        ),
                        const TextSpan(
                          text: " Mau Latihan Soal apa kali ini?",
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
              ],
            );
          }

          return Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              width: double.infinity,
              height: 60.h,
              padding: EdgeInsets.symmetric(horizontal: 16.w),
            ),
          );
        },
      ),
    );
  }
}

class LearningTopicsGrid extends StatelessWidget {
  final LearningTopicBloc learningTopicBloc;
  const LearningTopicsGrid({super.key, required this.learningTopicBloc});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          learningTopicBloc..add(const GetLearningTopicsEvent()),
      child: BlocConsumer<LearningTopicBloc, LearningTopicState>(
        listener: (context, state) {
          if (state is LearningTopicFailed) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is LearningTopicLoaded) {
            return Container(
              padding: EdgeInsets.only(top: 24.h),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12.h,
                  crossAxisSpacing: 12.w,
                  mainAxisExtent: 220.h,
                ),
                itemCount: state.learningTopics.length,
                itemBuilder: (context, index) {
                  return LearningTopicGridWidget(
                    learningTopic: state.learningTopics[index],
                  );
                },
              ),
            );
          }

          return Container(
            padding: EdgeInsets.only(top: 24.h),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12.h,
                crossAxisSpacing: 12.w,
                mainAxisExtent: 220.h,
              ),
              itemCount: 10,
              itemBuilder: (context, index) {
                return const LearningTopicGridSkeleton();
              },
            ),
          );
        },
      ),
    );
  }
}
