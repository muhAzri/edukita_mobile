import 'dart:io';

import 'package:auth/data/datasources/auth_remote_datasource.dart';
import 'package:auth/domain/repositories/auth_repository.dart';
import 'package:core/common/exception.dart';
import 'package:core/common/failure.dart';
import 'package:dartz/dartz.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource authRemoteDatasource;

  AuthRepositoryImpl({required this.authRemoteDatasource});

  @override
  Future<Either<Failure, void>> login() async {
    try {
      await authRemoteDatasource.login();
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on SocketException {
      return const Left(ConnectionFailure("Failed to connect to the network"));
    }
  }
}
