import 'dart:io';

import 'package:core/common/exception.dart';
import 'package:core/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:profile/data/datasources/user_profile_datasource.dart';
import 'package:profile/domain/entities/user_profile.dart';
import 'package:profile/domain/repositories/user_profile_repository.dart';

class UserProfileRepositoryImpl implements UserProfileRepository {
  final UserProfileDatasource userProfileDatasource;

  UserProfileRepositoryImpl({required this.userProfileDatasource});

  @override
  Future<Either<Failure, UserProfile>> getUserProfile() async {
    try {
      final userProfileModel = await userProfileDatasource.getUserProfile();
      return Right(userProfileModel.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on SocketException {
      return const Left(ConnectionFailure("Failed to connect to the network"));
    }
  }
}
