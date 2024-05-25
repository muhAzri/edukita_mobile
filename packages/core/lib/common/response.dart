import 'package:json_annotation/json_annotation.dart';

part 'response.g.dart';

@JsonSerializable()
class MetaData {
  final String message;
  final int code;
  final String status;

  MetaData({
    required this.message,
    required this.code,
    required this.status,
  });

  factory MetaData.fromJson(Map<String, dynamic> json) =>
      _$MetaDataFromJson(json);
  Map<String, dynamic> toJson() => _$MetaDataToJson(this);
}

@JsonSerializable(genericArgumentFactories: true)
class ResponseModel<T> {
  final MetaData meta;
  final T? data;
  final String? error;

  ResponseModel({
    required this.meta,
    required this.data,
    this.error,
  });

  factory ResponseModel.fromJson(
          Map<String, dynamic> json, T Function(Object?) type) =>
      _$ResponseModelFromJson(json, type);
  Map<String, dynamic> toJson(Object Function(T value) toJsonT) =>
      _$ResponseModelToJson(this, toJsonT);
}
