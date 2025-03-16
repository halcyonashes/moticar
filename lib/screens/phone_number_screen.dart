import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/phone_number_bloc.dart';
import 'otp_verification_screen.dart';

class PhoneNumberScreen extends StatefulWidget {
  const PhoneNumberScreen({super.key});

  @override
  State<PhoneNumberScreen> createState() => _PhoneNumberScreenState();
}

class _PhoneNumberScreenState extends State<PhoneNumberScreen> {
  final TextEditingController _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PhoneNumberBloc(),
      child: Scaffold(
        appBar: AppBar(title: const Text("Enter Your Phone Number")),
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Enter your phone number to continue",
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 20),

              // 🔹 Phone Number Input
              TextField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: "Phone Number",
                  prefixIcon: const Icon(Icons.phone),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // 🔹 BlocConsumer for State Handling
              BlocConsumer<PhoneNumberBloc, PhoneNumberState>(
                listener: (context, state) {
                  if (state is PhoneNumberFailure) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.error), backgroundColor: Colors.red),
                    );
                  } else if (state is PhoneNumberSuccess) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OtpVerificationScreen(
                          phoneNumber: _phoneController.text,
                        ),
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  return SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        final phoneNumber = _phoneController.text;
                        context.read<PhoneNumberBloc>().add(
                          PhoneNumberSubmitted(phoneNumber: phoneNumber),
                        );
                      },
                      child: state is PhoneNumberLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text("Send OTP"),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
