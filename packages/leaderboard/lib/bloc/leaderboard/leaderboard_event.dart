part of 'leaderboard_bloc.dart';

sealed class LeaderboardEvent extends Equatable {
  const LeaderboardEvent();

  @override
  List<Object> get props => [];
}

class GetLeaderboardEvent extends LeaderboardEvent {}
