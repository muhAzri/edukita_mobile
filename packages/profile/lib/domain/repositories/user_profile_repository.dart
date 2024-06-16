import 'package:core/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:profile/domain/entities/user_profile.dart';

abstract class UserProfileRepository {
  Future<Either<Failure, UserProfile>> getUserProfile();
}
