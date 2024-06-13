import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:question/domain/entities/quiz_result.dart';

part 'quiz_result_model.g.dart';

@JsonSerializable()
class QuizResultModel extends Equatable {
  final bool isCorrect;
  final int previousElo;
  final int newElo;

  const QuizResultModel(
      {required this.isCorrect,
      required this.previousElo,
      required this.newElo});

  @override
  List<Object> get props => [isCorrect, previousElo, newElo];

  factory QuizResultModel.fromJson(Map<String, dynamic> json) =>
      _$QuizResultModelFromJson(json);

  Map<String, dynamic> toJson() => _$QuizResultModelToJson(this);

  QuizResult toEntity() {
    return QuizResult(
      isCorrect: isCorrect,
      previousElo: previousElo,
      newElo: newElo,
    );
  }
}
