import 'package:core/common/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RowLabelValueWidget extends StatelessWidget {
  final String label;
  final String value;
  const RowLabelValueWidget({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: primaryTextStyle.copyWith(
              fontWeight: bold,
            ),
          ),
          Text(
            value,
            style: primaryTextStyle.copyWith(
              fontWeight: bold,
            ),
          ),
        ],
      ),
    );
  }
}
