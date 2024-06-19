part of 'leaderboard_bloc.dart';

sealed class LeaderboardState extends Equatable {
  const LeaderboardState();

  @override
  List<Object> get props => [];
}

final class LeaderboardInitial extends LeaderboardState {}

final class LeaderboardLoading extends LeaderboardState {}

final class LeaderboardLoaded extends LeaderboardState {
  final List<Leaderboard> leaderboard;
  const LeaderboardLoaded(this.leaderboard);

  @override
  List<Object> get props => [leaderboard];
}

final class LeaderboardFailed extends LeaderboardState {
  final String message;
  const LeaderboardFailed(this.message);

  @override
  List<Object> get props => [message];
}
