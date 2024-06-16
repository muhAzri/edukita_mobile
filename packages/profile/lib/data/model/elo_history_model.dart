import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:profile/domain/entities/elo_history.dart';

part 'elo_history_model.g.dart';

@JsonSerializable()
class EloHistoryModel extends Equatable {
  final int elo;
  final String date;

  const EloHistoryModel({
    required this.elo,
    required this.date,
  });

  factory EloHistoryModel.fromJson(Map<String, dynamic> json) =>
      _$EloHistoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$EloHistoryModelToJson(this);

  EloHistory toEntity() => EloHistory(elo: elo, date: date);

  @override
  List<Object?> get props => [elo, date];
}
