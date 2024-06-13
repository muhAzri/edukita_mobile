import 'package:core/common/exception.dart';
import 'package:core/common/response.dart';
import 'package:dio/dio.dart';
import 'package:home/data/model/short_profile_model.dart';

abstract class ShortProfileDatasource {
  Future<ShortProfileModel> getShortProfile();
}

class ShortProfileDatasourceImpl implements ShortProfileDatasource {
  final Dio client;

  ShortProfileDatasourceImpl({required this.client});

  @override
  Future<ShortProfileModel> getShortProfile() async {
    try {
      final response = await client.get('/auth/user-short');

      final responseModel = ResponseModel<ShortProfileModel>.fromJson(
        response.data,
        (shortProfile) {
          final shortProfileModel =
              ShortProfileModel.fromJson(shortProfile as Map<String, dynamic>);
          return shortProfileModel;
        },
      );

      if (response.statusCode != 200) {
        throw ServerException(responseModel.error!);
      }

      return responseModel.data!;
    } catch (e) {
      if (e is ServerException) {
        throw ServerException(e.message);
      }

      if (e is DioException) {
        if (e.type == DioExceptionType.connectionError) {
          throw ServerException(
              "Connection Error. Please check your internet connection");
        }

        if (e.type == DioExceptionType.connectionTimeout) {
          throw ServerException(
              "Connection Timeout. Please check your internet connection");
        }
      }

      throw ServerException(e.toString());
    }
  }
}
