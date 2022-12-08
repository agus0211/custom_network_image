import 'ad_network_image_model.dart';
import 'ad_network_image_storage.dart';

class ADNetworkImageService {
  late ADNetworkImageStorage _imageStorage;

  ADNetworkImageService._internal() {
    _imageStorage = ADNetworkImageStorage();
  }

  static ADNetworkImageService shared = ADNetworkImageService._internal();

  /// saving single image cache.
  Future saveImage({
    required String url,
    required String encodedImage,
    required Duration duration,
  }) async {
    ADNetworkImageModel model = ADNetworkImageModel(
      image: encodedImage,
      expiredDate: DateTime.now().add(duration),
    );

    if (url.isNotEmpty && model.getMap().isNotEmpty) {
      return await _imageStorage.writeItem(
        key: url,
        content: model.getMap(),
      );
    }
    return false;
  }

  /// get image from single url.
  /// this function will try to get from storage first.
  /// image cache will be used if it has not expired.
  /// if the cache has been expired, this function will trying
  /// to get the image from network
  Future<String?> getImage(String url) async {
    Map<String, dynamic> jsonImage =
        await _imageStorage.readItem(key: url) ?? {};
    if (jsonImage.isNotEmpty) {
      ADNetworkImageModel model = ADNetworkImageModel.fromJson(jsonImage);
      if (model.expiredDate.isAfter(DateTime.now())) {
        return model.image;
      } else {
        await _imageStorage.removeItem(key: url);
      }
    }
    return null;
  }

  /// calling function to remove all image caches.
  Future removeAllCache() async {
    await _imageStorage.removeAll();
  }
}
