import 'package:core/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:home/domain/entities/learning_topic.dart';
import 'package:home/domain/repositories/learning_topic_repository.dart';

class GetLearningTopics {
  final LearningTopicRepository learningTopicRepository;

  GetLearningTopics(this.learningTopicRepository);

  Future<Either<Failure, List<LearningTopic>>> execute() async {
    return learningTopicRepository.getLearningTopics();
  }
}