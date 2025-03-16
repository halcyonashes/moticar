import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:libphonenumber/libphonenumber.dart'; // For phone validation

// 🔹 Events
abstract class PhoneNumberEvent {}

class PhoneNumberSubmitted extends PhoneNumberEvent {
  final String phoneNumber;
  PhoneNumberSubmitted({required this.phoneNumber});
}

// 🔹 States
abstract class PhoneNumberState {}

class PhoneNumberInitial extends PhoneNumberState {}

class PhoneNumberLoading extends PhoneNumberState {}

class PhoneNumberSuccess extends PhoneNumberState {}

class PhoneNumberFailure extends PhoneNumberState {
  final String error;
  PhoneNumberFailure(this.error);
}

// 🔹 Bloc
class PhoneNumberBloc extends Bloc<PhoneNumberEvent, PhoneNumberState> {
  PhoneNumberBloc() : super(PhoneNumberInitial()) {
    on<PhoneNumberSubmitted>(_onPhoneNumberSubmitted);
  }

  Future<void> _onPhoneNumberSubmitted(
      PhoneNumberSubmitted event, Emitter<PhoneNumberState> emit) async {
    emit(PhoneNumberLoading());

    final isValid = await PhoneNumberUtil.isValidPhoneNumber(
      phoneNumber: event.phoneNumber,
      isoCode: "US", // Change to your desired country code
    );

    if (!(isValid ?? false)) {
      emit(PhoneNumberFailure("Invalid phone number"));
      return;
    }

    await Future.delayed(const Duration(seconds: 2)); // Simulating API call

    emit(PhoneNumberSuccess());
  }
}
