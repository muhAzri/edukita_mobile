import 'dart:io';

import 'package:core/common/exception.dart';
import 'package:core/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:question/data/datasources/question_remote_datasource.dart';
import 'package:question/data/model/answer_model.dart';
import 'package:question/domain/entities/question.dart';
import 'package:question/domain/entities/quiz_result.dart';
import 'package:question/domain/repositories/question_repository.dart';

class QuestionRepositoryImpl implements QuestionRepository {
  final QuestionRemoteDatasource questionRemoteDatasource;

  QuestionRepositoryImpl({required this.questionRemoteDatasource});

  @override
  Future<Either<Failure, List<Question>>> getQuestions(
      String learningTopicId) async {
    try {
      final questions =
          await questionRemoteDatasource.getQuestions(learningTopicId).then(
                (value) => value
                    .map(
                      (model) => model.toEntity(),
                    )
                    .toList(),
              );

      return Right(questions);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on SocketException {
      return const Left(ConnectionFailure("Failed to connect to the network"));
    }
  }

  @override
  Future<Either<Failure, QuizResult>> answerQuestion(
      AnswerModel answerModel) async {
    try {
      final result = await questionRemoteDatasource
          .answerQuestion(answerModel)
          .then((value) => value.toEntity());
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }
}
