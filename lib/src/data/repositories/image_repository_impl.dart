import 'package:web_test_app/src/data/data_sources/pixabay_api.dart';
import 'package:web_test_app/src/domain/entities/image_model.dart';
import 'package:web_test_app/src/domain/entities/image_result.dart';
import 'package:web_test_app/src/domain/repositories/image_repository.dart';

class ImageRepositoryImpl implements ImageRepository {
  final PixabayApi _api;

  ImageRepositoryImpl(this._api);

  @override
  Future<ImageResult> getImages(String query, int page) async {
    final result = await _api.getImages(query, page);
    final imagesData = result['images'] as List<Map<String, dynamic>>;
    final images = imagesData.map((data) => ImageModel.fromMap(data)).toList();
    final totalHits = result['totalHits'] as int;
    return ImageResult(images, totalHits);
  }
}