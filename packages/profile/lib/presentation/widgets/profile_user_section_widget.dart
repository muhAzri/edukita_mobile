import 'package:core/common/extension.dart';
import 'package:core/common/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:profile/domain/entities/user_profile.dart';
import 'package:profile/presentation/widgets/profile_join_date_widget.dart';
import 'package:profile/presentation/widgets/profile_name_email_widget.dart';
import 'package:profile/presentation/widgets/profile_picture_widget.dart';
import 'package:shimmer/shimmer.dart';

class ProfileUserSectionWidget extends StatelessWidget {
  final UserProfile userProfile;
  const ProfileUserSectionWidget({super.key, required this.userProfile});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 8.w,
        vertical: 12.h,
      ),
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(
          color: secondaryTextColor.withOpacity(0.4),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProfilePictureWidget(
            imageUrl: userProfile.profilePicture,
          ),
          SizedBox(
            width: 8.w,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProfileNameEmailWidget(
                  name: userProfile.name,
                  email: userProfile.email,
                ),
                SizedBox(
                  height: 4.h,
                ),
                ProfileJoinDateWidget(
                  joinDate:
                      "Bergabung ${userProfile.createdAt.toMonthAndYear()}",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileUserSectionSkeletonWidget extends StatelessWidget {
  const ProfileUserSectionSkeletonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 8.w,
        vertical: 12.h,
      ),
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(
          color: secondaryTextColor.withOpacity(0.4),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              width: 72.w,
              height: 72.h,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey,
              ),
            ),
          ),
          SizedBox(
            width: 8.w,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    width: double.infinity,
                    height: 20.h,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(
                  height: 4.h,
                ),
                Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    width: 150.w,
                    height: 14.h,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(
                  height: 12.h,
                ),
                Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    width: 150.w,
                    height: 14.h,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
