import 'package:flutter_bloc/flutter_bloc.dart';

// 🔹 Events
abstract class AddDetailsEvent {}

class DOBChanged extends AddDetailsEvent {
  final DateTime dob;
  DOBChanged(this.dob);
}

class GenderChanged extends AddDetailsEvent {
  final String gender;
  GenderChanged(this.gender);
}

class CurrencyChanged extends AddDetailsEvent {
  final String currency;
  CurrencyChanged(this.currency);
}

class SubmitUserDetails extends AddDetailsEvent {}

// 🔹 States
abstract class UserDetailsState {}

class UserDetailsInitial extends UserDetailsState {}

class UserDetailsUpdated extends UserDetailsState {
  final DateTime? dob;
  final String? gender;
  final String? currency;

  UserDetailsUpdated({this.dob, this.gender, this.currency});
}

class UserDetailsSuccess extends UserDetailsState {}

// 🔹 Bloc
class UserDetailsBloc extends Bloc<AddDetailsEvent, UserDetailsState> {
  DateTime? _dob;
  String? _gender;
  String? _currency;

  UserDetailsBloc() : super(UserDetailsInitial()) {
    on<DOBChanged>((event, emit) {
      _dob = event.dob;
      emit(UserDetailsUpdated(dob: _dob, gender: _gender, currency: _currency));
    });

    on<GenderChanged>((event, emit) {
      _gender = event.gender;
      emit(UserDetailsUpdated(dob: _dob, gender: _gender, currency: _currency));
    });

    on<CurrencyChanged>((event, emit) {
      _currency = event.currency;
      emit(UserDetailsUpdated(dob: _dob, gender: _gender, currency: _currency));
    });

    on<SubmitUserDetails>((event, emit) {
      if (_dob != null && _gender != null && _currency != null) {
        emit(UserDetailsSuccess());
      }
    });
  }
}
