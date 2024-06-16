import 'package:equatable/equatable.dart';
import 'package:profile/domain/entities/elo_history.dart';

class UserProfile extends Equatable {
  final String id;
  final String name;
  final String email;
  final String profilePicture;
  final int currentElo;
  final int totalQuizAnswered;
  final List<EloHistory> userEloHistory;
  final int createdAt;
  final int updatedAt;

  const UserProfile({
    required this.id,
    required this.name,
    required this.email,
    required this.profilePicture,
    required this.currentElo,
    required this.totalQuizAnswered,
    required this.userEloHistory,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        email,
        profilePicture,
        currentElo,
        totalQuizAnswered,
        userEloHistory,
        createdAt,
        updatedAt,
      ];
}
