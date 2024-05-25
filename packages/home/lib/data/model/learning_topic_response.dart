import 'package:home/data/model/learning_topic_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'learning_topic_response.g.dart';

@JsonSerializable()
class LearningTopicResponse {
  final List<LearningTopicModel> learningTopics;

  LearningTopicResponse({required this.learningTopics});

  factory LearningTopicResponse.fromJson(Map<String, dynamic> json) =>
      _$LearningTopicResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LearningTopicResponseToJson(this);
}
