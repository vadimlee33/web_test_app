import 'package:web_test_app/src/domain/entities/image_result.dart';

abstract class ImageRepository {
  Future<ImageResult> getImages(String query, int page);
}
