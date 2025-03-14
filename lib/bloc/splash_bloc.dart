import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:async';

abstract class SplashEvent {}

class SplashStarted extends SplashEvent {}

abstract class SplashState {}

class SplashLoading extends SplashState {}

class SplashLoaded extends SplashState {}

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashLoading()) {
    on<SplashStarted>((event, emit) async {
      await Future.delayed(const Duration(seconds: 3)); // Simulating startup logic
      emit(SplashLoaded());
    });
  }
}
