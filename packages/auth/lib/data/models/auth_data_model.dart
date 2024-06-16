import 'package:json_annotation/json_annotation.dart';

part 'auth_data_model.g.dart';

@JsonSerializable()
class AuthDataModel {
  final String accessToken;
  final String refreshToken;

  AuthDataModel({
    required this.accessToken,
    required this.refreshToken,
  });

  factory AuthDataModel.fromJson(Map<String, dynamic> json) =>
      _$AuthDataModelFromJson(json);
  Map<String, dynamic> toJson() => _$AuthDataModelToJson(this);
}
