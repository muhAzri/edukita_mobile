import 'package:core/common/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileJoinDateWidget extends StatelessWidget {
  final String joinDate;

  const ProfileJoinDateWidget({
    super.key,
    required this.joinDate,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          WidgetSpan(
            child: Icon(
              Icons.access_time_filled,
              color: secondaryTextColor,
              size: 16.sp,
            ),
          ),
          TextSpan(
            text: " $joinDate",
            style: primaryTextStyle.copyWith(
              fontWeight: light,
              fontSize: 12.sp,
            ),
          ),
        ],
      ),
    );
  }
}
