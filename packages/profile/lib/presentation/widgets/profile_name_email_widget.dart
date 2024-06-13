import 'package:core/common/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileNameEmailWidget extends StatelessWidget {
  final String name;
  final String email;

  const ProfileNameEmailWidget({
    super.key,
    required this.name,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: primaryTextStyle.copyWith(
            fontWeight: bold,
            fontSize: 14.sp,
          ),
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
        ),
        Text(
          email,
          style: primaryTextStyle.copyWith(
            fontSize: 12.sp,
          ),
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
        ),
      ],
    );
  }
}
