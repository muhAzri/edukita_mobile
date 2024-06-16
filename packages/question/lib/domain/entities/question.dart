import 'package:equatable/equatable.dart';

class Question extends Equatable {
  final String id;
  final String learningTopicId;
  final String content;
  final List<String> answers;
  final int createdAt;
  final int updatedAt;

  const Question({
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
}
