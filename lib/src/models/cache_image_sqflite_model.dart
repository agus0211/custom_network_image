class CacheImageSqfliteModel {
  late String url;
  late String encodedImage;
  late DateTime expiredAt;

  CacheImageSqfliteModel({
    required this.encodedImage,
    required this.url,
    required this.expiredAt,
  });

  Map<String, dynamic> getMap() {
    return {
      'url': url,
      'encodedImage': encodedImage,
      'expiredAt': expiredAt.millisecondsSinceEpoch,
    };
  }

  CacheImageSqfliteModel.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    encodedImage = json['encodedImage'];
    expiredAt = DateTime.fromMillisecondsSinceEpoch(
      int.parse(json['expiredAt']),
    );
  }
}
