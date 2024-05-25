import 'package:core/common/exception.dart';
import 'package:core/common/response.dart';
import 'package:home/data/model/learning_topic_model.dart';
import 'package:home/data/model/learning_topic_response.dart';
import 'package:dio/dio.dart';

abstract class LearningTopicDatasource {
  Future<LearningTopicResponse> getLearningTopics();
}

class LearningTopicDatasourceImpl implements LearningTopicDatasource {
  final Dio client;

  LearningTopicDatasourceImpl({required this.client});

  @override
  Future<LearningTopicResponse> getLearningTopics() async {
    try {
      final response = await client.get('/learning-topics');

      final responseModel = ResponseModel<LearningTopicResponse>.fromJson(
        response.data,
        (learningTopic) {
          final learningTopicDart = learningTopic as List<dynamic>;

          final learningTopicsList = learningTopicDart
              .map(
                  (e) => LearningTopicModel.fromJson(e as Map<String, dynamic>))
              .toList();

          return LearningTopicResponse(learningTopics: learningTopicsList);
        },
      );

      if (response.statusCode != 200) {
        throw ServerException(responseModel.error!);
      }

      if (responseModel.data == null) {
        throw ServerException('Data is null');
      }

      return responseModel.data!;
    } catch (e) {
      if (e is ServerException) {
        throw ServerException(e.message);
      }

      throw ServerException(e.toString());
    }
  }
}
