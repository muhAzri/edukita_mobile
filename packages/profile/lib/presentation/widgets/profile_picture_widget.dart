import 'package:core/common/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfilePictureWidget extends StatelessWidget {
  final String imageUrl;
  const ProfilePictureWidget({
    super.key,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 72.w,
      height: 72.h,
      decoration: BoxDecoration(
        color: secondaryTextColor.withOpacity(0.4),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Container(
          width: 64.w,
          height: 64.h,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(imageUrl),
            ),
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}
