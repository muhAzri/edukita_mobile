part of 'short_profile_bloc.dart';

sealed class ShortProfileState extends Equatable {
  const ShortProfileState();

  @override
  List<Object> get props => [];
}

final class ShortProfileInitial extends ShortProfileState {}

final class ShortProfileLoading extends ShortProfileState {}

final class ShortProfileLoaded extends ShortProfileState {
  final ShortProfile shortProfile;

  const ShortProfileLoaded(this.shortProfile);
}

final class ShortProfileFailed extends ShortProfileState {
  final String message;

  const ShortProfileFailed(this.message);
}
