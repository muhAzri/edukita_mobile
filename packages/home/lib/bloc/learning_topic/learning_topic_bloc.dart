import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:home/domain/entities/learning_topic.dart';
import 'package:home/domain/usecases/get_learning_topics.dart';

part 'learning_topic_event.dart';
part 'learning_topic_state.dart';

class LearningTopicBloc extends Bloc<LearningTopicEvent, LearningTopicState> {
  GetLearningTopics getLearningTopics;

  LearningTopicBloc({required this.getLearningTopics})
      : super(LearningTopicInitial()) {
    on<GetLearningTopicsEvent>(onGetLearningTopics);
  }

  Future<void> onGetLearningTopics(GetLearningTopicsEvent event, emit) async {
    try {
      final result = await getLearningTopics.execute();

      result.fold((failure) {
        emit(
          LearningTopicFailed(
            failure.message,
          ),
        );
      }, (learningTopicData) {
        emit(
          LearningTopicLoaded(
            learningTopicData,
          ),
        );
      });
    } catch (e) {
      emit(
        LearningTopicFailed(
          e.toString(),
        ),
      );
    }
  }
}

