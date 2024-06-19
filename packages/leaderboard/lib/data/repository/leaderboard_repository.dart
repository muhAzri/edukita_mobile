import 'dart:io';

import 'package:core/common/exception.dart';
import 'package:core/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:leaderboard/data/datasources/leaderboard_datasource.dart';
import 'package:leaderboard/domain/entities/leaderboard.dart';
import 'package:leaderboard/domain/repository/leaderboard_repository.dart';

class LeaderboardRepositoryImpl implements LeaderboardRepository {
  final LeaderboardDatasource leaderboardDatasource;

  LeaderboardRepositoryImpl({required this.leaderboardDatasource});

  @override
  Future<Either<Failure, List<Leaderboard>>> getLeaderboard() async {
    try {
      final leaderboard = await leaderboardDatasource.getLeaderboard();
      final leaderboardEntity = leaderboard
          .map(
            (model) => model.toEntity(),
          )
          .toList();

      return Right(leaderboardEntity);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on SocketException {
      return const Left(ConnectionFailure("Failed to connect to the network"));
    }
  }
}
