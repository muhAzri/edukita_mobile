import 'package:core/common/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leaderboard/domain/entities/leaderboard.dart';
import 'package:shimmer/shimmer.dart';

class LeaderboardTileWidget extends StatelessWidget {
  final Leaderboard leaderboard;
  final int position;
  const LeaderboardTileWidget({
    super.key,
    required this.leaderboard,
    required this.position,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 12.w,
        vertical: 6.h,
      ),
      margin: EdgeInsets.only(
        bottom: 12.h,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          12.r,
        ),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 4,
            offset: const Offset(0, 3),
          )
        ],
      ),
      child: Row(
        children: [
          Text(
            "$position",
            style: primaryTextStyle.copyWith(
              fontWeight: bold,
              fontSize: 24.sp,
              color: secondaryColor,
            ),
          ),
          Container(
            width: 64.w,
            height: 64.h,
            decoration: BoxDecoration(
              color: secondaryTextColor.withOpacity(0.4),
              shape: BoxShape.circle,
            ),
            margin: EdgeInsets.only(left: 14.w, right: 12.w),
            child: Center(
              child: Container(
                width: 56.w,
                height: 56.h,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      leaderboard.profilePicture,
                    ),
                    fit: BoxFit.cover,
                  ),
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
          Expanded(
            child: Text(
              leaderboard.name,
              maxLines: 2,
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 6.w),
            decoration: BoxDecoration(
              color: accentColor,
              borderRadius: BorderRadius.circular(12.r),
            ),
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
            child: Text(
              "${leaderboard.elo}",
              style: whiteTextStyle.copyWith(
                fontWeight: bold,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class LeaderboardTileSkeletonWidget extends StatelessWidget {
  const LeaderboardTileSkeletonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 12.w,
        vertical: 6.h,
      ),
      margin: EdgeInsets.only(
        bottom: 12.h,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          12.r,
        ),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 4,
            offset: const Offset(0, 3),
          )
        ],
      ),
      child: Row(
        children: [
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              width: 24.w,
              height: 24.h,
              color: Colors.white,
            ),
          ),
          Container(
            width: 64.w,
            height: 64.h,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              shape: BoxShape.circle,
            ),
            margin: EdgeInsets.only(left: 6.w, right: 12.w),
          ),
          Expanded(
            child: Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                width: double.infinity,
                height: 20.h,
                color: Colors.white,
              ),
            ),
          ),
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              width: 50.w,
              height: 20.h,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(12.r),
              ),
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
            ),
          ),
        ],
      ),
    );
  }
}
