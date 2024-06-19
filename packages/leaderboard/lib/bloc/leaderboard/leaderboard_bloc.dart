import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:leaderboard/domain/entities/leaderboard.dart';
import 'package:leaderboard/domain/usecases/get_leaderboard.dart';

part 'leaderboard_event.dart';
part 'leaderboard_state.dart';

class LeaderboardBloc extends Bloc<LeaderboardEvent, LeaderboardState> {
  final GetLeaderboard getLeaderboard;

  LeaderboardBloc({required this.getLeaderboard})
      : super(LeaderboardInitial()) {
    on<GetLeaderboardEvent>(onGetLeaderboard);
  }

  Future<void> onGetLeaderboard(
      GetLeaderboardEvent event, Emitter<LeaderboardState> emit) async {
    try {
      emit(LeaderboardLoading());

      final leaderboardResult = await getLeaderboard.execute();

      leaderboardResult.fold(
        (failure) => emit(
          LeaderboardFailed(
            failure.message,
          ),
        ),
        (leaderboard) => emit(
          LeaderboardLoaded(
            leaderboard,
          ),
        ),
      );
    } catch (e) {
      emit(
        LeaderboardFailed(
          e.toString(),
        ),
      );
    }
  }
}
