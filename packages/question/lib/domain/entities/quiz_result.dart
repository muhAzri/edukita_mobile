import 'package:equatable/equatable.dart';

class QuizResult extends Equatable {
  final bool isCorrect;
  final int previousElo;
  final int newElo;

  const QuizResult({
    required this.isCorrect,
    required this.previousElo,
    required this.newElo,
  });

  @override
  List<Object> get props => [isCorrect, previousElo, newElo];
}
