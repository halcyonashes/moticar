import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../bloc/sign_up_bloc.dart';
import 'verify_email_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignUpBloc(
        supabase: Supabase.instance.client,
      ),
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Sign Up",
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),

              // Username Input
              TextField(
                controller: _usernameController,
                decoration: const InputDecoration(labelText: "Username"),
              ),
              const SizedBox(height: 10),

              // Email Input
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: "Email"),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 10),

              // Password Input
              TextField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: "Password"),
                obscureText: true,
              ),
              const SizedBox(height: 10),

              // Confirm Password Input
              TextField(
                controller: _confirmPasswordController,
                decoration: const InputDecoration(labelText: "Confirm Password"),
                obscureText: true,
              ),
              const SizedBox(height: 20),

              // Terms Agreement Checkbox
              Row(
                children: [
                  Checkbox(
                    value: _isChecked,
                    onChanged: (bool? value) {
                      setState(() {
                        _isChecked = value ?? false;
                      });
                    },
                  ),
                  const Text("I agree to the "),
                  GestureDetector(
                    onTap: () {
                      // Navigate to Terms & Conditions
                    },
                    child: const Text(
                      "Terms and Conditions",
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              // Sign Up Button with BlocConsumer
              BlocConsumer<SignUpBloc, SignUpState>(
                listener: (context, state) {
                  if (state is SignUpFailure) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.error), backgroundColor: Colors.red),
                    );
                  } else if (state is SignUpEmailVerificationRequired) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const VerifyEmailScreen(),
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  return ElevatedButton(
                    onPressed: _isChecked
                        ? () {
                            final email = _emailController.text;
                            final password = _passwordController.text;
                            final confirmPassword = _confirmPasswordController.text;
                            final username = _usernameController.text;

                            if (password != confirmPassword) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Passwords do not match"),
                                  backgroundColor: Colors.red,
                                ),
                              );
                              return;
                            }

                            context.read<SignUpBloc>().add(
                              SignUpSubmitted(
                                email: email,
                                password: password,
                                username: username,
                              ),
                            );
                          }
                        : null,
                    child: state is SignUpLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text("Sign Up"),
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