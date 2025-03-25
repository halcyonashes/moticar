import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:io';

// 🔹 Events
abstract class UploadImageEvent {}

class ImageUploaded extends UploadImageEvent {
  final File image;
  final String componentType; // "first" or "second"
  ImageUploaded({required this.image, required this.componentType});
}

class AIProcessingRequested extends UploadImageEvent {
  final String componentType;
  AIProcessingRequested({required this.componentType});
}

// 🔹 States
abstract class UploadImageState {}

class UploadImageInitial extends UploadImageState {}

class ImageSelected extends UploadImageState {
  final File image;
  final String componentType;
  ImageSelected({required this.image, required this.componentType});
}

class AIProcessing extends UploadImageState {}

class AISummaryGenerated extends UploadImageState {
  final String summary;
  AISummaryGenerated({required this.summary});
}

class AdditionalDetailsRequired extends UploadImageState {}

// 🔹 Bloc
class UploadImageBloc extends Bloc<UploadImageEvent, UploadImageState> {
  UploadImageBloc() : super(UploadImageInitial()) {
    on<ImageUploaded>((event, emit) {
      emit(ImageSelected(image: event.image, componentType: event.componentType));
    });

    on<AIProcessingRequested>((event, emit) async {
      emit(AIProcessing());
      await Future.delayed(const Duration(seconds: 2)); // Simulating AI summary processing
      emit(AISummaryGenerated(summary: "AI Summary for ${event.componentType} component."));
    });
  }
}
