import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:question/data/model/answer_model.dart';
import 'package:question/domain/entities/question.dart';
import 'package:question/domain/entities/quiz_result.dart';
import 'package:question/domain/usecases/answer_question.dart';
import 'package:question/domain/usecases/get_question.dart';

part 'question_event.dart';
part 'question_state.dart';

class QuestionBloc extends Bloc<QuestionEvent, QuestionState> {
  final GetQuestion getQuestionUsecase;
  final AnswerQuestion answerQuestionUsecase;

  QuestionBloc(
      {required this.getQuestionUsecase, required this.answerQuestionUsecase})
      : super(QuestionInitial()) {
    on<GetQuestionsEvent>(onGetQuestions);
    on<AnswerQuestionEvent>(onAnswerQuestion);
  }

  Future<void> onGetQuestions(GetQuestionsEvent event, emit) async {
    try {
      emit(QuestionLoading());

      final questions = await getQuestionUsecase.execute(event.learningTopicId);

      questions.fold(
        (failure) => emit(
          QuestionFailed(message: failure.message),
        ),
        (success) => emit(
          QuestionLoaded(questions: success),
        ),
      );
    } catch (e) {
      emit(
        QuestionFailed(
          message: e.toString(),
        ),
      );
    }
  }

  Future<void> onAnswerQuestion(AnswerQuestionEvent event, emit) async {
    try {
      final result = await answerQuestionUsecase.execute(event.answer);
      result.fold(
        (failure) => emit(
          QuestionFailed(message: failure.message),
        ),
        (success) => emit(
          QuestionAnswered(result: success),
        ),
      );
    } catch (e) {
      emit(
        QuestionFailed(
          message: e.toString(),
        ),
      );
    }
  }
}
