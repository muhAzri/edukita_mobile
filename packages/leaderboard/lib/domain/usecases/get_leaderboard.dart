import 'package:core/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:leaderboard/domain/entities/leaderboard.dart';
import 'package:leaderboard/domain/repository/leaderboard_repository.dart';

class GetLeaderboard {
  final LeaderboardRepository repository;

  GetLeaderboard({required this.repository});

  Future<Either<Failure, List<Leaderboard>>> execute() async {
    return repository.getLeaderboard();
  }
}
