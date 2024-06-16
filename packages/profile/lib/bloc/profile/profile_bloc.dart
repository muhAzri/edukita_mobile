import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:profile/domain/entities/user_profile.dart';
import 'package:profile/domain/usecases/get_user_profile.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetUserProfile getUserProfile;

  ProfileBloc({required this.getUserProfile}) : super(ProfileInitial()) {
    on<GetUserProfileEvent>(onGetUserProfile);
  }

  Future<void> onGetUserProfile(GetUserProfileEvent event, emit) async {
    try {
      emit(ProfileLoading());

      final result = await getUserProfile.execute();

      result.fold((failure) {
        emit(
          ProfileFailed(
            failure.message,
          ),
        );
      }, (userProfile) {
        emit(
          ProfileLoaded(
            userProfile,
          ),
        );
      });
    } catch (e) {
      emit(
        ProfileFailed(
          e.toString(),
        ),
      );
    }
  }
}
