import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:question/domain/entities/question.dart';

part 'question_model.g.dart';

@JsonSerializable()
class QuestionModel extends Equatable {
  final String id;
  final String learningTopicId;
  final String content;
  final List<String> answers;
  final int createdAt;
  final int updatedAt;

  const QuestionModel({
    required this.id,
    required this.learningTopicId,
    required this.content,
    required this.answers,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object> get props => [
        id,
        learningTopicId,
        content,
        answers,
        createdAt,
        updatedAt,
      ];

  factory QuestionModel.fromJson(Map<String, dynamic> json) =>
      _$QuestionModelFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionModelToJson(this);

  Question toEntity() {
    return Question(
      id: id,
      learningTopicId: learningTopicId,
      content: content,
      answers: answers,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
