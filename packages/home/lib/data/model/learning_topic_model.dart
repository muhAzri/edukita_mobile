import 'package:equatable/equatable.dart';
import 'package:home/domain/entities/learning_topic.dart';
import 'package:json_annotation/json_annotation.dart';

part 'learning_topic_model.g.dart';

@JsonSerializable()
class LearningTopicModel extends Equatable {
  final String id;
  final String name;
  final String slug;
  final String description;
  final String type;
  final String icon;
  final int createdAt;
  final int updatedAt;

  const LearningTopicModel({
    required this.id,
    required this.name,
    required this.slug,
    required this.description,
    required this.type,
    required this.icon,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        slug,
        description,
        type,
        icon,
        createdAt,
        updatedAt,
      ];

  LearningTopic toEntity() {
    return LearningTopic(
      id: id,
      name: name,
      slug: slug,
      description: description,
      type: type,
      icon: icon,
      createdAt: DateTime.fromMillisecondsSinceEpoch(createdAt),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(updatedAt),
    );
  }

  factory LearningTopicModel.fromJson(Map<String, dynamic> json) =>
      _$LearningTopicModelFromJson(json);

  Map<String, dynamic> toJson() => _$LearningTopicModelToJson(this);
}
