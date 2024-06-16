part of 'profile_bloc.dart';

sealed class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

final class ProfileInitial extends ProfileState {}

final class ProfileLoading extends ProfileState {}

final class ProfileLoaded extends ProfileState {
  final UserProfile userProfile;
  const ProfileLoaded(this.userProfile);
}

final class ProfileFailed extends ProfileState {
  final String message;
  const ProfileFailed(this.message);
}
