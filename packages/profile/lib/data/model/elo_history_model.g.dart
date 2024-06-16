// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'elo_history_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EloHistoryModel _$EloHistoryModelFromJson(Map<String, dynamic> json) =>
    EloHistoryModel(
      elo: (json['elo'] as num).toInt(),
      date: json['date'] as String,
    );

Map<String, dynamic> _$EloHistoryModelToJson(EloHistoryModel instance) =>
    <String, dynamic>{
      'elo': instance.elo,
      'date': instance.date,
    };
