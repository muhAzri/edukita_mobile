import 'package:core/common/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:profile/bloc/profile/profile_bloc.dart';
import 'package:profile/presentation/widgets/profile_stats_section_widget.dart';
import 'package:profile/presentation/widgets/profile_user_section_widget.dart';

class ProfileScreen extends StatelessWidget {
  final ProfileBloc profileBloc;
  const ProfileScreen({super.key, required this.profileBloc});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => profileBloc..add(GetUserProfileEvent()),
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: SafeArea(
          child: BlocConsumer<ProfileBloc, ProfileState>(
            listener: (context, state) {
              if (state is ProfileFailed) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                  ),
                );
              }
            },
            builder: (context, state) {
              if (state is ProfileLoaded) {
                return ListView(
                  padding: EdgeInsets.symmetric(
                    horizontal: 24.w,
                    vertical: 12.h,
                  ),
                  children: [
                    ProfileUserSectionWidget(
                      userProfile: state.userProfile,
                    ),
                    ProfileStatsSectionWidget(
                      userProfile: state.userProfile,
                    ),
                  ],
                );
              }

              return ListView(
                padding: EdgeInsets.symmetric(
                  horizontal: 24.w,
                  vertical: 12.h,
                ),
                children: const [
                  ProfileUserSectionSkeletonWidget(),
                  ProfileStatsSectionSkeletonWidget(),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
