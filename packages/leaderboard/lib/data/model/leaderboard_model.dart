import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:leaderboard/domain/entities/leaderboard.dart';

part 'leaderboard_model.g.dart';

@JsonSerializable()
class LeaderboardModel extends Equatable {
  final String userId;
  final String name;
  final String email;
  final String profilePicture;
  final int elo;

  const LeaderboardModel({
    required this.userId,
    required this.name,
    required this.email,
    required this.profilePicture,
    required this.elo,
  });

  factory LeaderboardModel.fromJson(Map<String, dynamic> json) =>
      _$LeaderboardModelFromJson(json);

  Map<String, dynamic> toJson() => _$LeaderboardModelToJson(this);

  Leaderboard toEntity() {
    return Leaderboard(
      userId: userId,
      name: name,
      email: email,
      profilePicture: profilePicture,
      elo: elo,
    );
  }

  @override
  List<Object?> get props => [
        userId,
        name,
        email,
        profilePicture,
        elo,
      ];
}
