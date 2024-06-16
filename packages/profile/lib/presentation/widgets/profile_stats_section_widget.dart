import 'package:core/common/styles.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:profile/domain/entities/elo_history.dart';
import 'package:profile/domain/entities/user_profile.dart';
import 'package:profile/presentation/widgets/row_label_value_widget.dart';
import 'package:shimmer/shimmer.dart';

class ProfileStatsSectionWidget extends StatelessWidget {
  final UserProfile userProfile;
  const ProfileStatsSectionWidget({super.key, required this.userProfile});

  double getMaxY(int elo) {
    if (elo > 2000 && elo < 5000) {
      return 5000;
    }

    if (elo > 1000 && elo < 2000) {
      return 2000;
    }

    return 2000;
  }

  List<FlSpot> getChartData(UserProfile data) {
    return data.userEloHistory.asMap().entries.map((entry) {
      int index = entry.key;
      EloHistory eloHistory = entry.value;
      return FlSpot(index.toDouble(), eloHistory.elo.toDouble());
    }).toList();
  }

  List<String> getFormattedDates(UserProfile data) {
    return data.userEloHistory.map((e) => formatDate(e.date)).toList();
  }

  String formatDate(String date) {
    final DateTime parsedDate = DateTime.parse(date);
    final DateFormat formatter = DateFormat('d MMM');
    return formatter.format(parsedDate);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 8.w,
        vertical: 12.h,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(
          color: secondaryTextColor.withOpacity(0.4),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Statistik Puzzle",
            style: primaryTextStyle.copyWith(fontWeight: bold, fontSize: 16.sp),
          ),
          SizedBox(
            height: 8.h,
          ),
          Center(
            child: SizedBox(
              height: 300.h,
              width: 280.w,
              child: userProfile.userEloHistory.isEmpty
                  ? Center(
                      child: Text(
                        'Data Statistik Belum Tersedia Jawab Quis Terlebih Dahulu',
                        style: primaryTextStyle.copyWith(
                          fontSize: 18.sp,
                          fontWeight: bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    )
                  : LineChart(
                      LineChartData(
                        maxY: getMaxY(userProfile.currentElo),
                        minY: 0,
                        baselineY: 0,
                        gridData: const FlGridData(show: true),
                        titlesData: FlTitlesData(
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              reservedSize: 40,
                              showTitles: true,
                              getTitlesWidget: (value, meta) {
                                final index = value.toInt();
                                if (index >= 0 &&
                                    index <
                                        getFormattedDates(userProfile).length) {
                                  return SideTitleWidget(
                                    axisSide: meta.axisSide,
                                    child: Text(
                                      getFormattedDates(userProfile)[index],
                                      style: primaryTextStyle.copyWith(
                                          fontSize: 12.sp),
                                    ),
                                  );
                                }
                                return const SizedBox.shrink();
                              },
                              interval: 1,
                            ),
                          ),
                          leftTitles: const AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                          topTitles: const AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                          rightTitles: const AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                        ),
                        borderData: FlBorderData(
                          show: true,
                          border: Border.all(
                            color: Colors.black,
                            width: 1,
                          ),
                        ),
                        lineBarsData: [
                          LineChartBarData(
                            spots: getChartData(userProfile),
                            dotData: const FlDotData(show: true),
                            belowBarData: BarAreaData(show: false),
                          ),
                        ],
                      ),
                    ),
            ),
          ),
          SizedBox(
            height: 8.h,
          ),
          RowLabelValueWidget(
            label: "Rating Sekarang",
            value: "${userProfile.currentElo}",
          ),
          RowLabelValueWidget(
            label: "Total Soal Dikerjakan",
            value: "${userProfile.totalQuizAnswered}",
          ),
        ],
      ),
    );
  }
}

class ProfileStatsSectionSkeletonWidget extends StatelessWidget {
  const ProfileStatsSectionSkeletonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 8.w,
        vertical: 12.h,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(
          color: secondaryTextColor.withOpacity(0.4),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              width: 200.w,
              height: 20.h,
              color: Colors.grey,
            ),
          ),
          SizedBox(
            height: 8.h,
          ),
          Center(
            child: Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                height: 300.h,
                width: 280.w,
                color: Colors.grey,
              ),
            ),
          ),
          SizedBox(
            height: 8.h,
          ),
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
            height: 8.h,
          ),
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              width: double.infinity,
              height: 20.h,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
