class ADNetworkImageModel {
  late String image;
  late DateTime expiredDate;

  ADNetworkImageModel({
    required this.image,
    required this.expiredDate,
  });

  Map<String, dynamic> getMap() {
    return {
      'image': image,
      'expiredDate': expiredDate.microsecondsSinceEpoch,
    };
  }

  ADNetworkImageModel.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    expiredDate = DateTime.fromMicrosecondsSinceEpoch(json['expiredDate']);
  }
}
