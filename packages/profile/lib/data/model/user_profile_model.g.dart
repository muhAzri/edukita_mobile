// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserProfileModel _$UserProfileModelFromJson(Map<String, dynamic> json) =>
    UserProfileModel(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      profilePicture: json['profilePicture'] as String,
      currentElo: (json['currentElo'] as num).toInt(),
      totalQuizAnswered: (json['totalQuizAnswered'] as num).toInt(),
      userEloHistory: (json['userEloHistory'] as List<dynamic>)
          .map((e) => EloHistoryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      createdAt: (json['createdAt'] as num).toInt(),
      updatedAt: (json['updatedAt'] as num).toInt(),
    );

Map<String, dynamic> _$UserProfileModelToJson(UserProfileModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'profilePicture': instance.profilePicture,
      'currentElo': instance.currentElo,
      'totalQuizAnswered': instance.totalQuizAnswered,
      'userEloHistory': instance.userEloHistory,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
