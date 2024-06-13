import 'package:core/common/exception.dart';
import 'package:core/common/response.dart';
import 'package:dio/dio.dart';
import 'package:question/data/model/answer_model.dart';
import 'package:question/data/model/question_model.dart';
import 'package:question/data/model/quiz_result_model.dart';

abstract class QuestionRemoteDatasource {
  Future<List<QuestionModel>> getQuestions(String learningTopicId);
  Future<QuizResultModel> answerQuestion(AnswerModel answerModel);
}

class QuestionRemoteDatasourceImpl implements QuestionRemoteDatasource {
  final Dio client;

  QuestionRemoteDatasourceImpl({required this.client});

  @override
  Future<List<QuestionModel>> getQuestions(String learningTopicId) async {
    try {
      final response = await client.get('/questions/$learningTopicId/quiz');

      final responseModel = ResponseModel<List<QuestionModel>>.fromJson(
        response.data,
        (questions) {
          final questionsDart = questions as List<dynamic>;
          final questionsList = questionsDart
              .map((e) => QuestionModel.fromJson(e as Map<String, dynamic>))
              .toList();
          return questionsList;
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

  @override
  Future<QuizResultModel> answerQuestion(AnswerModel answerModel) async {
    try {
      final response = await client.post(
        '/questions/answer',
        data: answerModel.toJson(),
      );

      final responseModel = ResponseModel<QuizResultModel>.fromJson(
        response.data,
        (data) => QuizResultModel.fromJson(data as Map<String, dynamic>),
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
