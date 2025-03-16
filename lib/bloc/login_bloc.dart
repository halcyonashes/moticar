import 'package:email_validator/email_validator.dart' show EmailValidator;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:async';


// 🔹 Events
abstract class LoginEvent {}

class LoginSubmitted extends LoginEvent {
  final String email;
  final String password;

  LoginSubmitted({required this.email, required this.password});
}

// 🔹 States
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {}

class LoginFailure extends LoginState {
  final String error;
  LoginFailure(this.error);
}

class LoginEmailVerificationRequired extends LoginState {}

// 🔹 Bloc
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginSubmitted>(_onLoginSubmitted);
  }

  Future<void> _onLoginSubmitted(
      LoginSubmitted event, Emitter<LoginState> emit) async {
    // 🔹 Validate email format
    if (!EmailValidator.validate(event.email)) {
      emit(LoginFailure("Invalid email format"));
      return;
    }

    // 🔹 Validate password length
    if (event.password.length < 8) {
      emit(LoginFailure("Password must be at least 8 characters"));
      return;
    }

    emit(LoginLoading());

    await Future.delayed(const Duration(seconds: 2)); // TODO Replace with API call

    if (event.email == "test@example.com" && event.password == "password123") {
      // 🔹 Simulate user needs email verification
      emit(LoginEmailVerificationRequired());
    } else {
      emit(LoginFailure("Invalid email or password"));
    }
  }
}
