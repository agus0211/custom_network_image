class CacheImageModel {
  late String encodedImage;
  late DateTime expiredDate;

  CacheImageModel({
    required this.encodedImage,
    required this.expiredDate,
  });

  Map<String, dynamic> getMap() {
    return {
      'encodedImage': encodedImage,
      'expiredDate': expiredDate.microsecondsSinceEpoch,
    };
  }

  CacheImageModel.fromJson(Map<String, dynamic> json) {
    encodedImage = json['encodedImage'];
    expiredDate = DateTime.fromMicrosecondsSinceEpoch(json['expiredDate']);
  }
}
