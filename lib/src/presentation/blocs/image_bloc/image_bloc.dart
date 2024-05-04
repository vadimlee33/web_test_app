import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_test_app/src/domain/entities/image_model.dart';
import 'package:web_test_app/src/domain/repositories/image_repository.dart';

part 'image_event.dart';
part 'image_state.dart';

class ImageBloc extends Bloc<ImageEvent, ImageState> {
  final ImageRepository imageRepository;
  int pageNumber = 1;
  String query = '';
  int totalHits = 0;
  bool isLoadingNewImages = false;
  List<ImageModel> imagesList = [];
  ImageBloc(this.imageRepository) : super(ImageInitial()) {
    on<ImageFetched>(_onImageFetched);
  }

  Future<void> _onImageFetched(
      ImageFetched event, Emitter<ImageState> emit) async {
    try {
      isLoadingNewImages = true;
      bool isQueryChanged = false;

      if (event.query != query) {
        query = event.query;
        pageNumber = 1;
        imagesList = [];
        isQueryChanged = true;
      }

      final images = await imageRepository.getImages(event.query, pageNumber);
      totalHits = images.totalHits;
      pageNumber++;

      imagesList = List.from(imagesList)..addAll(images.images);

      if (imagesList.isEmpty) {
        emit(ImagesEmpty());
      } else {
        emit(ImageSuccess(
            imagesList, imagesList.length >= totalHits, isQueryChanged));
        isLoadingNewImages = false;
      }
    } catch (_) {
      emit(ImageFailure());
    }
  }
}
