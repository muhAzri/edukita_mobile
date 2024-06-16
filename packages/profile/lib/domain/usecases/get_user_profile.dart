import 'package:core/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:profile/domain/entities/user_profile.dart';
import 'package:profile/domain/repositories/user_profile_repository.dart';

class GetUserProfile {
  final UserProfileRepository userProfileRepository;

  GetUserProfile(this.userProfileRepository);

  Future<Either<Failure, UserProfile>> execute() {
    return userProfileRepository.getUserProfile();
  }
}
