import 'package:equatable/equatable.dart';
import 'package:home/domain/entities/short_profile.dart';
import 'package:json_annotation/json_annotation.dart';

part 'short_profile_model.g.dart';

@JsonSerializable()
class ShortProfileModel extends Equatable {
  final String name;

  const ShortProfileModel({required this.name});

  @override
  List<Object> get props => [name];

  factory ShortProfileModel.fromJson(Map<String, dynamic> json) =>
      _$ShortProfileModelFromJson(json);

  Map<String, dynamic> toJson() => _$ShortProfileModelToJson(this);

  ShortProfile toEntity() {
    return ShortProfile(name: name);
  }
}
