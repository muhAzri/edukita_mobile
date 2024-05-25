part of 'short_profile_bloc.dart';

sealed class ShortProfileEvent extends Equatable {
  const ShortProfileEvent();

  @override
  List<Object> get props => [];
}

class GetShortProfileEvent extends ShortProfileEvent {}
