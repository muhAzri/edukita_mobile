import 'package:core/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:question/domain/entities/question.dart';
import 'package:question/domain/repositories/question_repository.dart';

class GetQuestion {
  final QuestionRepository questionRepository;

  GetQuestion({
    required this.questionRepository,
  });

  Future<Either<Failure, List<Question>>> execute(
    String learningTopicId,
  ) async {
    return questionRepository.getQuestions(learningTopicId);
  }
}
