import 'package:core/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:question/data/model/answer_model.dart';
import 'package:question/domain/entities/quiz_result.dart';
import 'package:question/domain/repositories/question_repository.dart';

class AnswerQuestion {
  final QuestionRepository questionRepository;

  AnswerQuestion({required this.questionRepository});

  Future<Either<Failure, QuizResult>> execute(AnswerModel answerModel) async {
    return questionRepository.answerQuestion(answerModel);
  }
}
