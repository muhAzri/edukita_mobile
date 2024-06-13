import 'package:core/common/styles.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:profile/presentation/widgets/profile_join_date_widget.dart';
import 'package:profile/presentation/widgets/profile_name_email_widget.dart';
import 'package:profile/presentation/widgets/profile_picture_widget.dart';
import 'package:profile/presentation/widgets/row_label_value_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(
            horizontal: 24.w,
            vertical: 12.h,
          ),
          children: const [
            ProfileSection(),
            StatsSection(),
          ],
        ),
      ),
    );
  }
}

List<Map<String, dynamic>> fetchDataFromAPI() {
  return [
    {'date': '2022-01-01', 'score': 1000},
    {'date': '2022-01-02', 'score': 1010},
    {'date': '2022-01-03', 'score': 1100},
    {'date': '2022-01-04', 'score': 1150},
    {'date': '2022-01-05', 'score': 1100},
    {'date': '2022-01-06', 'score': 1200},
    {'date': '2022-01-07', 'score': 1100},
  ];
}

List<FlSpot> getChartData() {
  final data = fetchDataFromAPI();
  return data.asMap().entries.map((entry) {
    int index = entry.key;
    Map<String, dynamic> value = entry.value;
    return FlSpot(index.toDouble(), value['score'].toDouble());
  }).toList();
}

List<String> getFormattedDates() {
  final data = fetchDataFromAPI();
  return data.map((e) => formatDate(e['date'])).toList();
}

String formatDate(String date) {
  final DateTime parsedDate = DateTime.parse(date);
  final DateFormat formatter = DateFormat('d MMM');
  return formatter.format(parsedDate);
}

class ProfileSection extends StatelessWidget {
  const ProfileSection({super.key});

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
          const ProfilePictureWidget(
            imageUrl: "https://avatars.githubusercontent.com/u/90236860?v=4",
          ),
          SizedBox(
            width: 8.w,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const ProfileNameEmailWidget(
                  name: "Muhammad Azri Fatihah Susanto",
                  email: "muhammad.azri.f.s@gmail.com",
                ),
                SizedBox(
                  height: 4.h,
                ),
                const ProfileJoinDateWidget(
                  joinDate: "Bergabung Februari 2024",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class StatsSection extends StatelessWidget {
  const StatsSection({super.key});

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
              child: LineChart(
                LineChartData(
                  gridData: const FlGridData(show: true),
                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        reservedSize: 40,
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          final index = value.toInt();
                          if (index >= 0 &&
                              index < getFormattedDates().length) {
                            return SideTitleWidget(
                              axisSide: meta.axisSide,
                              child: Text(
                                getFormattedDates()[index],
                                style:
                                    primaryTextStyle.copyWith(fontSize: 12.sp),
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
                      spots: getChartData(),
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
          const RowLabelValueWidget(
            label: "Rating Sekarang",
            value: "1256",
          ),
          const RowLabelValueWidget(
            label: "Total Soal Dikerjakan",
            value: "30",
          ),
        ],
      ),
    );
  }
}
