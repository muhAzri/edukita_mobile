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
import 'package:home/bloc/bloc/short_profile_bloc.dart';
import 'package:home/bloc/learning_topic/learning_topic_bloc.dart';
import 'package:home/data/datasources/learning_topic_datasource.dart';
import 'package:home/data/datasources/short_profile_datasource.dart';
import 'package:home/data/repositories/learning_topic_repository_impl.dart';
import 'package:home/data/repositories/short_profile_repository_impl.dart';
import 'package:home/domain/repositories/learning_topic_repository.dart';
import 'package:home/domain/repositories/short_profile_repository.dart';
import 'package:home/domain/usecases/get_learning_topics.dart';
import 'package:home/domain/usecases/get_short_profile.dart';
import 'package:profile/bloc/profile/profile_bloc.dart';
import 'package:profile/data/datasources/user_profile_datasource.dart';
import 'package:profile/data/repositories/user_profile_repository.dart';
import 'package:profile/domain/repositories/user_profile_repository.dart';
import 'package:profile/domain/usecases/get_user_profile.dart';
import 'package:question/bloc/question/question_bloc.dart';
import 'package:question/data/datasources/question_remote_datasource.dart';
import 'package:question/data/repositories/question_repository.dart';
import 'package:question/domain/repositories/question_repository.dart';
import 'package:question/domain/usecases/answer_question.dart';
import 'package:question/domain/usecases/get_question.dart';

final locator = GetIt.instance;

Future<void> initializeInjector() async {
  //HTTP Client
  locator.registerSingleton<Dio>(DioConfig().client);

  //BLOC
  locator.registerFactory(
    () => LoginBloc(
      login: locator(),
    ),
  );

  locator.registerFactory(
    () => LearningTopicBloc(
      getLearningTopics: locator(),
    ),
  );

  locator.registerFactory(
    () => ShortProfileBloc(
      getShortProfile: locator(),
    ),
  );

  locator.registerFactory(
    () => QuestionBloc(
      getQuestionUsecase: locator(),
      answerQuestionUsecase: locator(),
    ),
  );

  locator.registerFactory(
    () => ProfileBloc(
      getUserProfile: locator(),
    ),
  );

  //Usecases
  locator.registerLazySingleton(
    () => Login(
      locator(),
    ),
  );

  locator.registerLazySingleton(
    () => GetLearningTopics(
      locator(),
    ),
  );

  locator.registerLazySingleton(
    () => GetShortProfile(
      locator(),
    ),
  );

  locator.registerLazySingleton(
    () => GetQuestion(
      questionRepository: locator(),
    ),
  );

  locator.registerLazySingleton(
    () => AnswerQuestion(
      questionRepository: locator(),
    ),
  );

  locator.registerLazySingleton(
    () => GetUserProfile(
      locator(),
    ),
  );

  //Repositories`
  locator.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      authRemoteDatasource: locator(),
    ),
  );

  locator.registerLazySingleton<LearningTopicRepository>(
    () => LearningTopicRepositoryImpl(
      learningTopicDatasource: locator(),
    ),
  );

  locator.registerLazySingleton<ShortProfileRepository>(
    () => ShortProfileRepositoryImpl(
      shortProfileDatasource: locator(),
    ),
  );

  locator.registerLazySingleton<QuestionRepository>(
    () => QuestionRepositoryImpl(
      questionRemoteDatasource: locator(),
    ),
  );

  locator.registerLazySingleton<UserProfileRepository>(
    () => UserProfileRepositoryImpl(
      userProfileDatasource: locator(),
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

  locator.registerLazySingleton<LearningTopicDatasource>(
      () => LearningTopicDatasourceImpl(
            client: locator(),
          ));

  locator.registerLazySingleton<ShortProfileDatasource>(
    () => ShortProfileDatasourceImpl(
      client: locator(),
    ),
  );

  locator.registerLazySingleton<QuestionRemoteDatasource>(
    () => QuestionRemoteDatasourceImpl(
      client: locator(),
    ),
  );

  locator.registerLazySingleton<UserProfileDatasource>(
    () => UserProfileDatasourceImpl(
      client: locator(),
    ),
  );

  //MISC

  locator.registerLazySingleton<FlutterSecureStorage>(
      () => const FlutterSecureStorage());

  locator.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);

  locator.registerLazySingleton<GoogleSignIn>(() => GoogleSignIn());
}
