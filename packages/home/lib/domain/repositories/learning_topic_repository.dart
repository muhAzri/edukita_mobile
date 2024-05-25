import 'package:core/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:home/domain/entities/learning_topic.dart';

abstract class LearningTopicRepository {
  Future<Either<Failure, List<LearningTopic>>> getLearningTopics();
}
