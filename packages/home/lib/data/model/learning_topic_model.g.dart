// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'learning_topic_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LearningTopicModel _$LearningTopicModelFromJson(Map<String, dynamic> json) =>
    LearningTopicModel(
      id: json['id'] as String,
      name: json['name'] as String,
      slug: json['slug'] as String,
      description: json['description'] as String,
      type: json['type'] as String,
      icon: json['icon'] as String,
      createdAt: (json['createdAt'] as num).toInt(),
      updatedAt: (json['updatedAt'] as num).toInt(),
    );

Map<String, dynamic> _$LearningTopicModelToJson(LearningTopicModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'slug': instance.slug,
      'description': instance.description,
      'type': instance.type,
      'icon': instance.icon,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
