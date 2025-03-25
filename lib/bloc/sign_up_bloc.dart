import 'package:email_validator/email_validator.dart' show EmailValidator;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'dart:async';

// Events
abstract class SignUpEvent {}

class SignUpSubmitted extends SignUpEvent {
  final String email;
  final String password;
  final String username;

  SignUpSubmitted({
    required this.email,
    required this.password,
    required this.username,
  });
}

// States
abstract class SignUpState {}

class SignUpInitial extends SignUpState {}

class SignUpLoading extends SignUpState {}

class SignUpSuccess extends SignUpState {}

class SignUpFailure extends SignUpState {
  final String error;
  SignUpFailure(this.error);
}

class SignUpEmailVerificationRequired extends SignUpState {}

// Bloc
class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final SupabaseClient supabase;

  SignUpBloc({required this.supabase}) : super(SignUpInitial()) {
    on<SignUpSubmitted>(_onSignUpSubmitted);
  }

  Future<void> _onSignUpSubmitted(
      SignUpSubmitted event, Emitter<SignUpState> emit) async {
    // Validate email format
    if (!EmailValidator.validate(event.email)) {
      emit(SignUpFailure("Invalid email format"));
      return;
    }

    // Validate password length
    if (event.password.length < 8) {
      emit(SignUpFailure("Password must be at least 8 characters"));
      return;
    }

    emit(SignUpLoading());

    try {
      final AuthResponse res = await supabase.auth.signUp(
        email: event.email,
        password: event.password,
        data: {
          'username': event.username,
        },
      );

      if (res.user != null) {
        emit(SignUpEmailVerificationRequired());
      } else {
        emit(SignUpFailure("Failed to create account"));
      }
    } catch (e) {
      emit(SignUpFailure(e.toString()));
    }
  }
} 