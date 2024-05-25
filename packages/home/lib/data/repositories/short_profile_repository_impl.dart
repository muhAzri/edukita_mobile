import 'dart:io';

import 'package:core/common/exception.dart';
import 'package:core/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:home/data/datasources/short_profile_datasource.dart';
import 'package:home/domain/entities/short_profile.dart';
import 'package:home/domain/repositories/short_profile_repository.dart';

class ShortProfileRepositoryImpl implements ShortProfileRepository {
  final ShortProfileDatasource shortProfileDatasource;

  ShortProfileRepositoryImpl({required this.shortProfileDatasource});

  @override
  Future<Either<Failure, ShortProfile>> getShortProfile() async {
    try {
      final shortProfileModel = await shortProfileDatasource.getShortProfile();

      return Right(shortProfileModel.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on SocketException {
      return const Left(ConnectionFailure("Failed to connect to the network"));
    }
  }
}
