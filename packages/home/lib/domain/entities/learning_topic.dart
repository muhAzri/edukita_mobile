import 'package:equatable/equatable.dart';

class LearningTopic extends Equatable {
  final String id;
  final String name;
  final String slug;
  final String description;
  final String type;
  final String icon;
  final DateTime createdAt;
  final DateTime updatedAt;

  const LearningTopic({
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
  List<Object> get props =>
      [id, name, slug, description, type, icon, createdAt, updatedAt];
}
