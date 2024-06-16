import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:profile/data/model/elo_history_model.dart';
import 'package:profile/domain/entities/user_profile.dart';

part 'user_profile_model.g.dart';

@JsonSerializable()
class UserProfileModel extends Equatable {
  final String id;
  final String name;
  final String email;
  final String profilePicture;
  final int currentElo;
  final int totalQuizAnswered;
  final List<EloHistoryModel> userEloHistory;
  final int createdAt;
  final int updatedAt;

  const UserProfileModel({
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

  factory UserProfileModel.fromJson(Map<String, dynamic> json) =>
      _$UserProfileModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserProfileModelToJson(this);

  UserProfile toEntity() {
    final userEloHistoryEntity = userEloHistory
        .map(
          (userEloHistoryModel) => userEloHistoryModel.toEntity(),
        )
        .toList();

    return UserProfile(
      id: id,
      name: name,
      email: email,
      profilePicture: profilePicture,
      currentElo: currentElo,
      totalQuizAnswered: totalQuizAnswered,
      userEloHistory: userEloHistoryEntity,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

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
