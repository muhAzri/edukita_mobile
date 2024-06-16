import 'package:equatable/equatable.dart';

class EloHistory extends Equatable {
  final int elo;
  final String date;

  const EloHistory({required this.elo, required this.date});

  @override
  List<Object?> get props => [elo, date];
}
