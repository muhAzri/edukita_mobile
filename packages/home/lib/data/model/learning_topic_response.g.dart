// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'learning_topic_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LearningTopicResponse _$LearningTopicResponseFromJson(
        Map<String, dynamic> json) =>
    LearningTopicResponse(
      learningTopics: (json['learningTopics'] as List<dynamic>)
          .map((e) => LearningTopicModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$LearningTopicResponseToJson(
        LearningTopicResponse instance) =>
    <String, dynamic>{
      'learningTopics': instance.learningTopics,
    };
