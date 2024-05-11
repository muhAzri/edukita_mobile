import 'package:auth/domain/repositories/auth_repository.dart';
import 'package:core/common/failure.dart';
import 'package:dartz/dartz.dart';

class Login {
  final AuthRepository authRepository;

  Login(this.authRepository);

  Future<Either<Failure, void>> call() async {
    return authRepository.login();
  }
}
