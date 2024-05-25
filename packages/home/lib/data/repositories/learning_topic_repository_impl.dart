import 'dart:io';

import 'package:core/common/exception.dart';
import 'package:core/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:home/data/datasources/learning_topic_datasource.dart';
import 'package:home/domain/entities/learning_topic.dart';
import 'package:home/domain/repositories/learning_topic_repository.dart';

class LearningTopicRepositoryImpl implements LearningTopicRepository {
  final LearningTopicDatasource learningTopicDatasource;

  LearningTopicRepositoryImpl({required this.learningTopicDatasource});

  @override
  Future<Either<Failure, List<LearningTopic>>> getLearningTopics() async {
    try {
      final learningTopicsModels =
          await learningTopicDatasource.getLearningTopics();
      final learningTopics = learningTopicsModels.learningTopics
          .map((model) => model.toEntity())
          .toList();

      return Right(learningTopics);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on SocketException {
      return const Left(ConnectionFailure("Failed to connect to the network"));
    }
  }
}
