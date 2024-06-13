part of 'question_bloc.dart';

sealed class QuestionState extends Equatable {
  const QuestionState();

  @override
  List<Object> get props => [];
}

final class QuestionInitial extends QuestionState {}

final class QuestionLoading extends QuestionState {}

final class QuestionLoaded extends QuestionState {
  final List<Question> questions;
  const QuestionLoaded({required this.questions});

  @override
  List<Object> get props => [questions];
}

final class QuestionFailed extends QuestionState {
  final String message;
  const QuestionFailed({required this.message});

  @override
  List<Object> get props => [message];
}

final class QuestionAnswered extends QuestionState {
  final QuizResult result;
  const QuestionAnswered({required this.result});

  @override
  List<Object> get props => [result];
}
