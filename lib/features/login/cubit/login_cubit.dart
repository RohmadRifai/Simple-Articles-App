import 'package:email_validator/email_validator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_application/features/login/model/user_model.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  bool isValid(String email, String password) {
    if (email.isEmpty && password.isEmpty) {
      emit(LoginFailure(message: "Username & password can't empty"));
      return false;
    } else if (email.isEmpty) {
      emit(LoginFailure(message: "Username can't empty"));
      return false;
    } else if (!EmailValidator.validate(email)) {
      emit(LoginFailure(message: 'The email must be a valid email address'));
      return false;
    } else if (password.isEmpty) {
      emit(LoginFailure(message: "Password can't empty"));
      return false;
    } else if (password.length < 5) {
      emit(LoginFailure(message: "The password must be at least 5 characters"));
      return false;
    }

    return true;
  }

  void login(String email, String password) async {
    emit(LoginInProgress());

    final check = isValid(email, password);
    if (!check) {
      return;
    }

    try {
      final user = await User.login(email, password);
      emit(LoginSuccess(user: user));
    } catch (_) {
      emit(LoginFailure(message: 'There is something wrong'));
    }
  }

  // Visibility
  void change(bool value) => emit(LoginVisibility(value: value));
}
