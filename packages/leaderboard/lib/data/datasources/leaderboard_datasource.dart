import 'package:core/common/exception.dart';
import 'package:core/common/response.dart';
import 'package:dio/dio.dart';
import 'package:leaderboard/data/model/leaderboard_model.dart';

abstract class LeaderboardDatasource {
  Future<List<LeaderboardModel>> getLeaderboard();
}

class LeaderboardDatasourceImpl implements LeaderboardDatasource {
  final Dio client;

  LeaderboardDatasourceImpl({required this.client});

  @override
  Future<List<LeaderboardModel>> getLeaderboard() async {
    try {
      final response = await client.get('/leaderboard');

      final responseModel = ResponseModel<List<LeaderboardModel>>.fromJson(
        response.data,
        (leaderboard) {
          final leaderboardDart = leaderboard as List<dynamic>;
          final leaderboardList = leaderboardDart
              .map((e) => LeaderboardModel.fromJson(e as Map<String, dynamic>))
              .toList();
          return leaderboardList;
        },
      );

      if (response.statusCode != 200) {
        throw ServerException(responseModel.error!);
      }

      if (responseModel.data == null) {
        throw ServerException('Data is null');
      }

      return responseModel.data!;
    } catch (e) {
      if (e is ServerException) {
        throw ServerException(e.message);
      }

      throw ServerException(e.toString());
    }
  }
}
