import 'package:auth/domain/usecases/login.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final Login login;

  LoginBloc({required this.login}) : super(LoginInitial()) {
    on<DoLogin>(onLogin);
  }

  Future<void> onLogin(DoLogin event, emit) async {
    try {
      emit(LoginLoading());

      final result = await login.call();

      result.fold((failure) {
        emit(LoginFailed(failure.message));
      }, (success) {
        emit(LoginSuccess());
      });
    } catch (e) {
      emit(LoginFailed(e.toString()));
    }
  }
}
