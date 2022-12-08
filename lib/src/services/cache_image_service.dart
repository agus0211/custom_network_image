import 'dart:convert';
import 'package:custom_network_image/src/models/cache_image_model.dart';
import '../storage/cache_image_storage.dart';

class CacheImageService {
  late final CacheImageStorage _storage = CacheImageStorage.instance;

  Future<bool> saveImage({
    required String url,
    required String encodedImage,
    required Duration duration,
  }) async {
    CacheImageModel model = CacheImageModel(
      encodedImage: encodedImage,
      expiredDate: DateTime.now().add(duration),
    );
    final encoded = jsonEncode(model.getMap());

    if (url.isNotEmpty && encoded.isNotEmpty) {
      return await _storage.insertCache(url, encoded);
    }
    return false;
  }

  Future<String?> getImage(String url) async {
    String jsonImage = await _storage.getCache(url) ?? '';
    if (jsonImage.isNotEmpty) {
      CacheImageModel model = CacheImageModel.fromJson(jsonDecode(jsonImage));
      if (model.expiredDate.isAfter(DateTime.now())) {
        return model.encodedImage;
      } else {
        await _storage.evictFromCache(url);
      }
    }
    return null;
  }
}
