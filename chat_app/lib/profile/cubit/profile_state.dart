part of 'profile_cubit.dart';

class ProfileState extends Equatable {
  const ProfileState(
      {this.userState = const GeneralApiState(), this.edit = true});

  final GeneralApiState<List<User>> userState;
  final bool edit;

  ProfileState copyWith({
    GeneralApiState<List<User>>? userState,
    bool? edit,
  }) {
    return ProfileState(
      userState: userState ?? this.userState,
      edit: edit ?? this.edit,
    );
  }

  @override
  List<Object?> get props => [userState, edit];
}
