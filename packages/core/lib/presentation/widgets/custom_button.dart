import 'package:core/common/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final Function() onTap;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final double? width = double.infinity;
  final double? height;
  final BoxDecoration? boxDecoration;
  final TextStyle? labelTextStyle;

  const CustomButton({
    super.key,
    required this.label,
    required this.onTap,
    this.padding,
    this.margin,
    this.height,
    this.boxDecoration,
    this.labelTextStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: onTap,
        child: Container(
          margin: margin ?? EdgeInsets.zero,
          padding: padding ??
              EdgeInsets.symmetric(
                horizontal: 12.w,
                vertical: 12.h,
              ),
          decoration: boxDecoration ??
              BoxDecoration(
                  color: accentColor,
                  borderRadius: BorderRadius.circular(12.r)),
          child: Center(
            child: Text(
              label,
              style: labelTextStyle ??
                  whiteTextStyle.copyWith(
                    fontSize: 24.sp,
                  ),
            ),
          ),
        ),
      ),
    );
  }
}
