part of 'user_cubit.dart';

@immutable
sealed class UserState {}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserSuccess extends UserState {
  final User user;
  UserSuccess(this.user);
}

class UserLogout extends UserState {}

class UserFailure extends UserState {
  final String error;
  UserFailure(this.error);
}
