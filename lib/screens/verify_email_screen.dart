import 'package:flutter/material.dart';
import 'package:moticar/widgets/buttons.dart';

class VerifyEmailScreen extends StatelessWidget {
  const VerifyEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Verify Email")),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Verify Your Email",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Text(
              "We've sent a verification link to your email. Please check your inbox and click the link to continue.",
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),

            // 🔹 Resend Email Button
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Verification email sent!")),
                );
              },
              child: const Text("Resend Verification Email"),
            ),

            const SizedBox(height: 20),

            // 🔹 Continue Button
            PrimaryButton(
              onPressed: () {
                // Navigate to next screen (e.g., Home)
              },
              title: 'Continue',
            ),
          ],
        ),
      ),
    );
  }
}
