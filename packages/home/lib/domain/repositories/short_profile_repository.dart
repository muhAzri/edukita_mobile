import 'package:core/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:home/domain/entities/short_profile.dart';

abstract class ShortProfileRepository {
  Future<Either<Failure, ShortProfile>> getShortProfile();
}
