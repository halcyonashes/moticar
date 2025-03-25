import 'package:flutter_bloc/flutter_bloc.dart';

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

class PhoneNumberSuccess extends PhoneNumberState {
  final String formattedNumber;
  PhoneNumberSuccess(this.formattedNumber);
}

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

    try {
      // Remove all non-digit characters
      final digitsOnly = event.phoneNumber.replaceAll(RegExp(r'[^\d]'), '');
      
      if (digitsOnly.length != 10) {
        emit(PhoneNumberFailure("Phone number must contain exactly 10 digits"));
        return;
      }

      // Format the phone number with spaces for readability
      final formattedNumber = _formatPhoneNumber(digitsOnly);
      
      await Future.delayed(const Duration(seconds: 2)); // Simulating API call
      emit(PhoneNumberSuccess(formattedNumber));
    } catch (e) {
      emit(PhoneNumberFailure("Error processing phone number: ${e.toString()}"));
    }
  }

  String _formatPhoneNumber(String digits) {
    // Format as XXX XXX XXXX
    return '${digits.substring(0, 3)} ${digits.substring(3, 6)} ${digits.substring(6)}';
  }
}
