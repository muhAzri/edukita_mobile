import 'package:core/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:leaderboard/domain/entities/leaderboard.dart';

abstract class LeaderboardRepository {
  Future<Either<Failure, List<Leaderboard>>> getLeaderboard();
}
