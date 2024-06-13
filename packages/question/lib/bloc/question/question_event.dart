part of 'question_bloc.dart';

sealed class QuestionEvent extends Equatable {
  const QuestionEvent();

  @override
  List<Object> get props => [];
}

class GetQuestionsEvent extends QuestionEvent {
  final String learningTopicId;
  const GetQuestionsEvent(this.learningTopicId);

  @override
  List<Object> get props => [learningTopicId];
}

class AnswerQuestionEvent extends QuestionEvent {
  final AnswerModel answer;

  const AnswerQuestionEvent({required this.answer});

  @override
  List<Object> get props => [answer];
}
