import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:core/common/styles.dart';
import 'package:core/presentation/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:question/bloc/question/question_bloc.dart';
import 'package:question/data/model/answer_model.dart';
import 'package:question/domain/entities/question.dart';
import 'package:question/presentation/widgets/question_options_tile.dart';
import 'package:question/utils/quiz_dialog.dart';

class QuestionScreen extends StatefulWidget {
  final String learningTopicID;
  final QuestionBloc questionBloc;

  const QuestionScreen({
    super.key,
    required this.learningTopicID,
    required this.questionBloc,
  });

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  int? selectedAnswer;
  int currentIndex = 0;
  int questionLength = 0;
  Timer? _timer;
  int _seconds = 0;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _seconds++;
      });
    });
  }

  String get _formattedTime {
    final minutes = (_seconds ~/ 60).toString().padLeft(2, '0');
    final remainingSeconds = (_seconds % 60).toString().padLeft(2, '0');
    return '$minutes:$remainingSeconds';
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => widget.questionBloc
        ..add(
          GetQuestionsEvent(widget.learningTopicID),
        ),
      child: Scaffold(
        appBar: QuestionsScreenAppBar(
          formattedTime: _formattedTime,
        ),
        body: BlocConsumer<QuestionBloc, QuestionState>(
          buildWhen: (previous, current) => current is! QuestionAnswered,
          listener: (context, state) {
            if (state is QuestionFailed) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }

            if (state is QuestionAnswered) {
              _handleQuestionAnswered(context, state);
            }

            if (state is QuestionLoaded) {
              questionLength = state.questions.length;
            }
          },
          builder: (context, state) {
            if (state is QuestionLoaded) {
              return QuestionContent(
                questions: state.questions,
                currentIndex: currentIndex,
                selectedAnswer: selectedAnswer,
                onChangeAnswer: (value) => setState(() {
                  selectedAnswer = value;
                }),
                onAnswer: () {
                  final answer = AnswerModel(
                    questionId: state.questions[currentIndex].id,
                    answerIndex: selectedAnswer!,
                  );
                  context
                      .read<QuestionBloc>()
                      .add(AnswerQuestionEvent(answer: answer));
                },
              );
            }

            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }

  void _handleQuestionAnswered(BuildContext context, QuestionAnswered state) {
    if (currentIndex == questionLength - 1) {
      showQuizResultDialog(
        context: context,
        title: "Quiz Selesai \n",
        type: DialogType.info,
        desc:
            "Jawaban Mu ${state.result.isCorrect ? "Benar" : "Salah"} Skor Mu Berubah Jadi ${state.result.newElo} Dari ${state.result.previousElo}",
        btnText: "Kembali",
        onOkPressed: () {
          Navigator.pop(context);
        },
      );
    } else {
      showQuizResultDialog(
        context: context,
        title: state.result.isCorrect ? "Jawaban Benar" : "Jawaban Salah",
        desc:
            "Jawaban Mu ${state.result.isCorrect ? "Benar" : "Salah"} Skor Mu Berubah Jadi ${state.result.newElo} Dari ${state.result.previousElo}",
        type: state.result.isCorrect ? DialogType.success : DialogType.error,
        onOkPressed: () {
          setState(() {
            selectedAnswer = null;
            currentIndex += 1;
          });
        },
      );
    }
  }
}

class QuestionsScreenAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final String formattedTime;

  const QuestionsScreenAppBar({
    super.key,
    required this.formattedTime,
  });

  @override
  AppBar build(BuildContext context) {
    return AppBar(
      backgroundColor: accentColor,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text("Quiz", overflow: TextOverflow.ellipsis),
          Text(formattedTime, overflow: TextOverflow.ellipsis),
        ],
      ),
      iconTheme: IconThemeData(color: backgroundColor),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class QuestionContent extends StatelessWidget {
  final List<Question> questions;
  final int currentIndex;
  final int? selectedAnswer;
  final ValueChanged<int?> onChangeAnswer;
  final VoidCallback onAnswer;

  const QuestionContent({
    super.key,
    required this.questions,
    required this.currentIndex,
    required this.selectedAnswer,
    required this.onChangeAnswer,
    required this.onAnswer,
  });

  @override
  Widget build(BuildContext context) {
    final question = questions[currentIndex];
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 24.sp, vertical: 12.sp),
      children: [
        QuizContent(content: question.content),
        QuizOptions(
          selectedIndex: selectedAnswer,
          onChanged: onChangeAnswer,
          options: question.answers,
        ),
        SizedBox(height: 10.h),
        if (selectedAnswer != null)
          CustomButton(label: "Jawab", onTap: onAnswer),
        SizedBox(height: 40.h)
      ],
    );
  }
}

class QuizContent extends StatelessWidget {
  final String content;
  const QuizContent({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.sp, vertical: 44.sp),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 4,
            offset: const Offset(0, 3),
          ),
        ],
        borderRadius: BorderRadius.circular(24.r),
      ),
      child: Center(child: HtmlWidget(content)),
    );
  }
}

class QuizOptions extends StatelessWidget {
  final int? selectedIndex;
  final ValueChanged<int?> onChanged;
  final List<String> options;

  const QuizOptions({
    super.key,
    this.selectedIndex,
    required this.onChanged,
    required this.options,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 24.sp),
      child: Column(
        children: options.asMap().entries.map((entry) {
          int index = entry.key;
          String content = entry.value;
          return QuestionOptionsTile(
            index: index,
            selectedIndex: selectedIndex,
            optionsContent: content,
            onChanged: onChanged,
          );
        }).toList(),
      ),
    );
  }
}
