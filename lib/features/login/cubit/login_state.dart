part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginInProgress extends LoginState {}

class LoginFailure extends LoginState {
  final String message;

  LoginFailure({required this.message});
}

class LoginSuccess extends LoginState {
  final User user;

  LoginSuccess({required this.user});
}

class LoginVisibility extends LoginState {
  final bool value;

  LoginVisibility({required this.value});
}
