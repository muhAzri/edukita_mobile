import 'package:auth/bloc/login/login_bloc.dart';
import 'package:auth/data/datasources/auth_remote_datasource.dart';
import 'package:auth/data/repositories/auth_repository.dart';
import 'package:auth/domain/repositories/auth_repository.dart';
import 'package:auth/domain/usecases/login.dart';
import 'package:core/config/dio_config.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';

final locator = GetIt.instance;

Future<void> initializeInjector() async {
  //HTTP Client
  locator.registerFactory<Dio>(() => DioConfig().client);

  //BLOC
  locator.registerFactory(() => LoginBloc(login: locator()));

  //Usecases
  locator.registerLazySingleton(() => Login(locator()));

  //Repositories`
  locator.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      authRemoteDatasource: locator(),
    ),
  );

  //Data Sources
  locator.registerLazySingleton<AuthRemoteDatasource>(
    () => AuthRemoteDatasourceImpl(
      client: locator(),
      storage: locator(),
      firebaseAuth: locator(),
      googleSignIn: locator(),
    ),
  );

  //MISC

  locator.registerLazySingleton<FlutterSecureStorage>(
      () => const FlutterSecureStorage());

  locator.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);

  locator.registerLazySingleton<GoogleSignIn>(() => GoogleSignIn());
}
