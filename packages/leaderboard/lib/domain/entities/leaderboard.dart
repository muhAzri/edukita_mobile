import 'package:equatable/equatable.dart';

class Leaderboard extends Equatable {
  final String userId;
  final String name;
  final String email;
  final String profilePicture;
  final int elo;

  const Leaderboard({
    required this.userId,
    required this.name,
    required this.email,
    required this.profilePicture,
    required this.elo,
  });

  @override
  List<Object?> get props => [
        userId,
        name,
        email,
        profilePicture,
        elo,
      ];
}
