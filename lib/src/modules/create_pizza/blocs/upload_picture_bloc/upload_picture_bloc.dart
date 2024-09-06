import 'dart:typed_data';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pizza_repository/pizza_repository.dart';

part 'upload_picture_event.dart';
part 'upload_picture_state.dart';

// In UploadPictureBloc
class UploadPictureBloc extends Bloc<UploadPictureEvent, UploadPictureState> {
  final PizzaRepo pizzaRepo;

  UploadPictureBloc(this.pizzaRepo) : super(UploadPictureLoading()) {
    on<UploadPicture>((event, emit) async {
      emit(UploadPictureLoading()); // Emit loading state before starting upload
      try {
        // Upload the image and get the URL back
        String url = await pizzaRepo.sendImage(event.file, event.name);
        if (url.isNotEmpty) {
          // Check if URL is not empty
          print("Image uploaded successfully. URL: $url"); // Debugging line
          emit(UploadPictureSuccess(url)); // Emit success with image URL
        } else {
          throw Exception("Received empty URL");
        }
      } catch (e) {
        print("Error uploading image: $e"); // Debugging line
        emit(UploadPictureFailure()); // Emit failure on error
      }
    });
  }
}
