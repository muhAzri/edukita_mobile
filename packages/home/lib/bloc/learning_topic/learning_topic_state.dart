part of 'learning_topic_bloc.dart';

sealed class LearningTopicState extends Equatable {
  const LearningTopicState();

  @override
  List<Object> get props => [];
}

final class LearningTopicInitial extends LearningTopicState {}

final class LearningTopicLoading extends LearningTopicState {}

final class LearningTopicFailed extends LearningTopicState {
  final String message;
  const LearningTopicFailed(this.message);

  @override
  List<Object> get props => [message];
}

final class LearningTopicLoaded extends LearningTopicState {
  final List<LearningTopic> learningTopics;
  const LearningTopicLoaded(this.learningTopics);

  @override
  List<Object> get props => [learningTopics];
}
