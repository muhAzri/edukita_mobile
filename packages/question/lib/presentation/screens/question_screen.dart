import 'dart:async';

import 'package:core/common/styles.dart';
import 'package:core/presentation/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:question/presentation/widgets/question_options_tile.dart';

class QuestionScreen extends StatefulWidget {
  final String learningTopicID;
  const QuestionScreen({
    super.key,
    required this.learningTopicID,
  });

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  int? selectedAnswer;

  late Timer _timer;
  int _seconds = 0;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _seconds++;
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String _formatTime(int seconds) {
    final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
    final remainingSeconds = (seconds % 60).toString().padLeft(2, '0');
    return '$minutes:$remainingSeconds';
  }

  void onChangeAnswer(int? value) {
    setState(() {
      selectedAnswer = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: QuestionsScreenAppBar(
        formattedTime: _formatTime(_seconds),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 24.sp, vertical: 12.sp),
        children: [
          const QuizContent(
            content:
                '<p>Percobaan kinetika reaksi X + Y → P + Q menghasilkan data sebagai berikut: <br><br><table border="1"><tr><th>No.</th><th colspan="2">Konsentrasi awal</th><th>Waktu reaksi <br>(detik) </th></tr><tr><td></td><td>X (mol dm <sup>-3</sup>) </td><td>Y (mol dm <sup>-3</sup>) </td><td></td></tr><tr><td>1.</td><td>0,4</td><td>0,01</td><td>152 ± 8</td></tr><tr><td>2.</td><td>0,8</td><td>0,01</td><td>75 ± 4</td></tr><tr><td>3.</td><td>1,2</td><td>0,01</td><td>51 ± 3</td></tr></table><br>Orde reaksi terhadap X adalah .... </p>',
          ),
          QuizOptions(
            selectedIndex: selectedAnswer,
            onChanged: onChangeAnswer,
          ),
          SizedBox(
            height: 10.h,
          ),
          if (selectedAnswer != null)
            CustomButton(
              label: "Jawab",
              onTap: () {},
            ),
          SizedBox(
            height: 40.h,
          )
        ],
      ),
    );
  }
}

class QuestionsScreenAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final String formattedTime;

  const QuestionsScreenAppBar({super.key, required this.formattedTime});

  @override
  AppBar build(BuildContext context) {
    return AppBar(
      backgroundColor: accentColor,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Quiz",
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            formattedTime,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
      iconTheme: IconThemeData(
        color: backgroundColor,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class QuizContent extends StatelessWidget {
  final String content;
  const QuizContent({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 12.sp,
        vertical: 44.sp,
      ),
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
      child: Center(
        child: HtmlWidget(content),
      ),
    );
  }
}

class QuizOptions extends StatelessWidget {
  final int? selectedIndex;
  final ValueChanged<int?> onChanged;
  const QuizOptions({super.key, this.selectedIndex, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final List<String> options = [
      "<p>nol</p>",
      "<p>setengah</p>",
      "<p>satu</p>",
      "<p>dua</p>",
      "<p>tiga</p>"
    ];

    return Container(
      margin: EdgeInsets.only(
        top: 24.sp,
      ),
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
