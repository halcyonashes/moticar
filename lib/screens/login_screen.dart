import 'package:flutter/material.dart';
import 'package:moticar/bloc/login_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(),
      child: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset('assets/background.jpg', fit: BoxFit.cover),
            Container(color: Colors.black.withOpacity(0.4)),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/logo.png', height: 100),

                  const SizedBox(height: 20),

                  const Text(
                    "Welcome Back!",
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    "Sign in to continue",
                    style: TextStyle(fontSize: 18, color: Colors.white70),
                  ),

                  const SizedBox(height: 40),

                  TextField(
                    controller: _emailController,
                    decoration: const InputDecoration(labelText: "Email"),
                  ),

                  const SizedBox(height: 10),

                  TextField(
                    controller: _passwordController,
                    decoration: const InputDecoration(labelText: "Password"),
                    obscureText: true,
                  ),

                  const SizedBox(height: 20),

                  Row(
                    children: [
                      Checkbox(
                        value: _isChecked,
                        activeColor: Colors.white,
                        checkColor: Colors.black,
                        onChanged: (bool? value) {
                          setState(() {
                            _isChecked = value ?? false;
                          });
                        },
                      ),
                      const Text("I agree to the ", style: TextStyle(color: Colors.white)),
                      GestureDetector(
                        onTap: () {
                          // Navigate to Terms & Conditions
                        },
                        child: const Text(
                          "Terms and Conditions",
                          style: TextStyle(color: Colors.yellow, fontWeight: FontWeight.bold, decoration: TextDecoration.underline),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),

                  BlocConsumer<LoginBloc, LoginState>(
                    listener: (context, state) {
                      if (state is LoginFailure) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(state.error), backgroundColor: Colors.red),
                        );
                      } else if (state is LoginSuccess) {
                        // Navigate to the home page (replace with actual navigation)
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Login successful!"), backgroundColor: Colors.green),
                        );
                      }
                    },
                    builder: (context, state) {
                      return SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _isChecked
                              ? () {
                            final email = _emailController.text;
                            final password = _passwordController.text;

                            context.read<LoginBloc>().add(
                              LoginSubmitted(email: email, password: password),
                            );
                          }
                              : null,
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            backgroundColor: Colors.blue,
                            disabledBackgroundColor: Colors.grey,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: state is LoginLoading
                              ? const CircularProgressIndicator(color: Colors.white)
                              : const Text("Sign In", style: TextStyle(fontSize: 18, color: Colors.white)),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 15),

                  SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      onPressed: () {
                        // Navigate to sign-up page
                      },
                      style: TextButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 14)),
                      child: const Text("Create an Account", style: TextStyle(fontSize: 18, color: Colors.white)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
