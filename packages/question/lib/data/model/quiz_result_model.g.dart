// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz_result_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuizResultModel _$QuizResultModelFromJson(Map<String, dynamic> json) =>
    QuizResultModel(
      isCorrect: json['isCorrect'] as bool,
      previousElo: (json['previousElo'] as num).toInt(),
      newElo: (json['newElo'] as num).toInt(),
    );

Map<String, dynamic> _$QuizResultModelToJson(QuizResultModel instance) =>
    <String, dynamic>{
      'isCorrect': instance.isCorrect,
      'previousElo': instance.previousElo,
      'newElo': instance.newElo,
    };
