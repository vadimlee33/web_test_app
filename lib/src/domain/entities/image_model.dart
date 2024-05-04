class ImageModel {
  final String url;
  final int likes;
  final int views;

  ImageModel({required this.url, required this.likes, required this.views});

  factory ImageModel.fromMap(Map<String, dynamic> map) {
    return ImageModel(
      url: map['webformatURL'],
      likes: map['likes'],
      views: map['views'],
    );
  }
}