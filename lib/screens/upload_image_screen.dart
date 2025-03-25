import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:moticar/bloc/upload_image_bloc.dart';

class UploadImageScreen extends StatefulWidget {
  const UploadImageScreen({super.key});

  @override
  State<UploadImageScreen> createState() => UploadImageScreenState();
}

class UploadImageScreenState extends State<UploadImageScreen> {
  File? _firstImage;
  File? _secondImage;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(String componentType) async {
    final uploadImageBloc = context.read<UploadImageBloc>();

    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final file = File(pickedFile.path);

      if (context.mounted) {
        setState(() {
          if (componentType == "first") {
            _firstImage = file;
          } else {
            _secondImage = file;
          }
        });

        uploadImageBloc.add(ImageUploaded(image: file, componentType: componentType));
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UploadImageBloc(),
      child: Scaffold(
        appBar: AppBar(title: const Text("Upload Images")),
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // 🔹 Logo at the Top
              Image.asset(
                'assets/logo.png', // Replace with your actual logo asset
                height: 80,
              ),
              const SizedBox(height: 20),

              // 🔹 First Take a Picture Section
              const Text(
                "Take a Picture - Component 1",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              _firstImage != null
                  ? Image.file(_firstImage!, height: 150)
                  : ElevatedButton(
                onPressed: () => _pickImage("first"),
                child: const Text("Upload Photo"),
              ),
              const SizedBox(height: 10),

              // 🔹 AI Generated Summary (First Component)
              BlocBuilder<UploadImageBloc, UploadImageState>(
                builder: (context, state) {
                  if (state is AISummaryGenerated) {
                    return Text(state.summary);
                  }
                  return const SizedBox.shrink();
                },
              ),
              const SizedBox(height: 20),

              // 🔹 Second Take a Picture Section
              const Text(
                "Take a Picture - Component 2",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              _secondImage != null
                  ? Image.file(_secondImage!, height: 150)
                  : ElevatedButton(
                onPressed: () => _pickImage("second"),
                child: const Text("Upload Photo"),
              ),
              const SizedBox(height: 10),

              // 🔹 AI Generated Summary & Additional Details (Second Component)
              BlocBuilder<UploadImageBloc, UploadImageState>(
                builder: (context, state) {
                  if (state is AISummaryGenerated) {
                    return Column(
                      children: [
                        Text(state.summary),
                        const SizedBox(height: 10),
                        TextField(
                          decoration: const InputDecoration(labelText: "Additional Details"),
                        ),
                      ],
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),

              const SizedBox(height: 30),

              // 🔹 Continue Button
              ElevatedButton(
                onPressed: (_firstImage != null && _secondImage != null)
                    ? () {
                  // TODO: Navigate to the next screen
                }
                    : null,
                child: const Text("Continue"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
