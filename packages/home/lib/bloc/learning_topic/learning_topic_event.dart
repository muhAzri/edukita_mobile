part of 'learning_topic_bloc.dart';

sealed class LearningTopicEvent extends Equatable {
  const LearningTopicEvent();

  @override
  List<Object> get props => [];
}

class GetLearningTopicsEvent extends LearningTopicEvent {
  const GetLearningTopicsEvent();
}
