import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'answer_model.g.dart';

@JsonSerializable()
class AnswerModel extends Equatable {
  final String questionId;
  final int answerIndex;

  const AnswerModel({required this.questionId, required this.answerIndex});

  factory AnswerModel.fromJson(Map<String, dynamic> json) =>
      _$AnswerModelFromJson(json);

  Map<String, dynamic> toJson() => _$AnswerModelToJson(this);

  @override
  List<Object?> get props => [questionId, answerIndex];
}
