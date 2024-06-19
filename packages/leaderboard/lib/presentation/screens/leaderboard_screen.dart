import 'package:core/common/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leaderboard/bloc/leaderboard/leaderboard_bloc.dart';
import 'package:leaderboard/presentation/widgets/leaderboard_tile_widget.dart';

class LeaderboardScreen extends StatelessWidget {
  final LeaderboardBloc leaderboardBloc;
  const LeaderboardScreen({super.key, required this.leaderboardBloc});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => leaderboardBloc..add(GetLeaderboardEvent()),
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: SafeArea(
          child: BlocConsumer<LeaderboardBloc, LeaderboardState>(
            listener: (context, state) {
              if (state is LeaderboardFailed) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                  ),
                );
              }
            },
            builder: (context, state) {
              if (state is LeaderboardLoaded) {
                return ListView.builder(
                  padding: EdgeInsets.symmetric(
                    horizontal: 24.w,
                    vertical: 24.h,
                  ),
                  itemCount: state.leaderboard.length,
                  itemBuilder: (context, index) {
                    return LeaderboardTileWidget(
                      position: index + 1,
                      leaderboard: state.leaderboard[index],
                    );
                  },
                );
              }

              return ListView.builder(
                padding: EdgeInsets.symmetric(
                  horizontal: 24.w,
                  vertical: 24.h,
                ),
                itemCount: 10,
                itemBuilder: (context, index) {
                  return const LeaderboardTileSkeletonWidget();
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
