import 'package:core/common/exception.dart';
import 'package:core/common/response.dart';
import 'package:profile/data/model/user_profile_model.dart';
import 'package:dio/dio.dart';

abstract class UserProfileDatasource {
  Future<UserProfileModel> getUserProfile();
}

class UserProfileDatasourceImpl implements UserProfileDatasource {
  final Dio client;
  UserProfileDatasourceImpl({required this.client});

  @override
  Future<UserProfileModel> getUserProfile() async {
    try {
      final response = await client.get('/profile');

      final responseModel = ResponseModel<UserProfileModel>.fromJson(
        response.data,
        (data) => UserProfileModel.fromJson(data as Map<String, dynamic>),
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
