import 'package:core/common/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class QuestionOptionsTile extends StatelessWidget {
  final int? selectedIndex;
  final int index;
  final String optionsContent;
  final ValueChanged<int?> onChanged;
  const QuestionOptionsTile({
    super.key,
    this.selectedIndex,
    required this.index,
    required this.optionsContent,
    required this.onChanged,
  });

  String _getCharacter(int index) {
    switch (index) {
      case 0:
        return "A";
      case 1:
        return "B";
      case 2:
        return "C";
      case 3:
        return "D";
      case 4:
        return "E";
      default:
        return "";
    }
  }

  void onTap() {
    if (selectedIndex == index) {
      onChanged(null);
    } else {
      onChanged(index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 12.sp,
          vertical: 12.sp,
        ),
        margin: EdgeInsets.symmetric(vertical: 8.sp),
        decoration: BoxDecoration(
          color: index == selectedIndex
              ? accentColor.withOpacity(0.9)
              : Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 4,
              offset: const Offset(0, 3),
            ),
          ],
          borderRadius: BorderRadius.circular(24.r),
        ),
        child: Row(
          children: [
            Text(
              "${_getCharacter(index)}. ",
              style: index == selectedIndex
                  ? whiteTextStyle.copyWith(
                      fontSize: 16.sp,
                    )
                  : primaryTextStyle.copyWith(
                      fontSize: 16.sp,
                    ),
            ),
            Expanded(
              child: HtmlWidget(
                optionsContent,
                textStyle: index == selectedIndex
                    ? whiteTextStyle.copyWith(
                        fontSize: 16.sp,
                      )
                    : primaryTextStyle.copyWith(
                        fontSize: 16.sp,
                      ),
              ),
            ),
            Radio(
              fillColor: WidgetStateProperty.all(secondaryColor),
              value: index,
              groupValue: selectedIndex,
              onChanged: (int? value) {
                if (selectedIndex == index) {
                  onChanged(null);
                } else {
                  onChanged(index);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
