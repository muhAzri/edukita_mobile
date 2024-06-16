import 'package:core/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:home/domain/entities/short_profile.dart';
import 'package:home/domain/repositories/short_profile_repository.dart';

class GetShortProfile {
  final ShortProfileRepository repository;

  GetShortProfile(this.repository);

  Future<Either<Failure, ShortProfile>> execute() {
    return repository.getShortProfile();
  }
}
