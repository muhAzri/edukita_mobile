// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'answer_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AnswerModel _$AnswerModelFromJson(Map<String, dynamic> json) => AnswerModel(
      questionId: json['questionId'] as String,
      answerIndex: (json['answerIndex'] as num).toInt(),
    );

Map<String, dynamic> _$AnswerModelToJson(AnswerModel instance) =>
    <String, dynamic>{
      'questionId': instance.questionId,
      'answerIndex': instance.answerIndex,
    };
