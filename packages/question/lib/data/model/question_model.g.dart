// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuestionModel _$QuestionModelFromJson(Map<String, dynamic> json) =>
    QuestionModel(
      id: json['id'] as String,
      learningTopicId: json['learningTopicId'] as String,
      content: json['content'] as String,
      answers:
          (json['answers'] as List<dynamic>).map((e) => e as String).toList(),
      createdAt: (json['createdAt'] as num).toInt(),
      updatedAt: (json['updatedAt'] as num).toInt(),
    );

Map<String, dynamic> _$QuestionModelToJson(QuestionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'learningTopicId': instance.learningTopicId,
      'content': instance.content,
      'answers': instance.answers,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
