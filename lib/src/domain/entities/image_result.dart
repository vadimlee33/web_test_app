import 'package:web_test_app/src/domain/entities/image_model.dart';

class ImageResult {
  final List<ImageModel> images;
  final int totalHits;

  ImageResult(this.images, this.totalHits);
}