import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:chat_app/profile/model/profile_model.dart';
import 'package:chat_app/profile/repository/profile_repository.dart';
import 'package:image_picker/image_picker.dart';

import '../../chat/general_api_state.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this.repository)
      : super(
          const ProfileState(),
        ) {
    _userSubscription = repository.streamLoggedInUser().listen(updatedUser);
  }

  final ProfileRepostiory repository;
  late final StreamSubscription<List<User>> _userSubscription;

  @override
  Future<void> close() async {
    _userSubscription.cancel();
    return super.close();
  }

  void updatedUser(List<User> user) {
    emit(state.copyWith(
        userState:
            GeneralApiState(model: user, apiCallState: APICallState.loaded)));
  }

  Future<void> editProfile() async {
    emit(
      state.copyWith(
        userState: const GeneralApiState(apiCallState: APICallState.loading),
      ),
    );

    try {
      await repository.editProfile();
    } catch (e) {
      emit(
        state.copyWith(
          userState: GeneralApiState(
            model: state.userState.model,
            apiCallState: APICallState.failure,
            errorMessage: e.toString(),
          ),
        ),
      );
    }
  }

  Future<void> saveProfile(String name, String contact) async {
    emit(
      state.copyWith(
        userState: const GeneralApiState(apiCallState: APICallState.loading),
      ),
    );

    try {
      await repository.saveProfile(name, contact);
    } catch (e) {
      emit(
        state.copyWith(
          userState: GeneralApiState(
            model: state.userState.model,
            apiCallState: APICallState.failure,
            errorMessage: e.toString(),
          ),
        ),
      );
    }
  }

  Future<void> editPhoto(ImageSource source) async {
    emit(
      state.copyWith(
        userState: const GeneralApiState(apiCallState: APICallState.loading),
      ),
    );

    try {
      await repository.editPhoto(source);
    } catch (e) {
      emit(
        state.copyWith(
          userState: GeneralApiState(
            model: state.userState.model,
            apiCallState: APICallState.failure,
            errorMessage: e.toString(),
          ),
        ),
      );
    }
  }
}
