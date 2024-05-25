import 'package:equatable/equatable.dart';

class ShortProfile extends Equatable {
  final String name;

  const ShortProfile({required this.name});

  @override
  List<Object> get props => [name];
}
