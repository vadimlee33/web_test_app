import 'package:dio/dio.dart';

class PixabayApi {
  final Dio _dio;
  static const String _apiKey = "43713287-15a96d487605dc35cba7f06c5";

  PixabayApi(this._dio);

  Future<Map<String, dynamic>> getImages(String query, int page) async {
    final response = await _dio.get(
      'https://pixabay.com/api/',
      queryParameters: {
        'key': _apiKey,
        'q': query,
        'image_type': 'photo',
        'page': page,
        'per_page': 20,
        'min_width': 300,
        'min_height': 300,
      },
    );

    if (response.statusCode == 200) {
      return {
        'totalHits': response.data['totalHits'],
        'images': List<Map<String, dynamic>>.from(response.data['hits'])
      };
    } else {
      throw Exception('Failed to load images');
    }
  }
}
