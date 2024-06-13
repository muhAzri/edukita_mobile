import 'package:core/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:question/data/model/answer_model.dart';
import 'package:question/domain/entities/question.dart';
import 'package:question/domain/entities/quiz_result.dart';

abstract class QuestionRepository {
  Future<Either<Failure, List<Question>>> getQuestions(String learningTopicId);
  Future<Either<Failure, QuizResult>> answerQuestion(AnswerModel answerModel);
}
