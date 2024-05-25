import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:home/domain/entities/short_profile.dart';
import 'package:home/domain/usecases/get_short_profile.dart';

part 'short_profile_event.dart';
part 'short_profile_state.dart';

class ShortProfileBloc extends Bloc<ShortProfileEvent, ShortProfileState> {
  final GetShortProfile getShortProfile;

  ShortProfileBloc({required this.getShortProfile})
      : super(ShortProfileInitial()) {
    on<GetShortProfileEvent>(onGetShortProfile);
  }

  Future<void> onGetShortProfile(GetShortProfileEvent event, emit) async {
    try {
      final result = await getShortProfile.execute();

      result.fold((failure) {
        emit(
          ShortProfileFailed(
            failure.message,
          ),
        );
      }, (shortProfile) {
        emit(
          ShortProfileLoaded(
            shortProfile,
          ),
        );
      });
    } catch (e) {
      emit(
        ShortProfileFailed(
          e.toString(),
        ),
      );
    }
  }
}
