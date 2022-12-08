import 'package:custom_network_image/src/models/cache_image_model.dart';
import 'package:custom_network_image/src/storage/cache_file_storage.dart';

class CacheFileService {
  final CacheFileStorage _fileManager = CacheFileStorage.instance;

  Future saveImage({
    required String url,
    required String encodedImage,
    required Duration duration,
  }) async {
    CacheImageModel model = CacheImageModel(
      encodedImage: encodedImage,
      expiredDate: DateTime.now().add(duration),
    );

    if (url.isNotEmpty && model.getMap().isNotEmpty) {
      return await _fileManager.writeItem(
        key: url,
        content: model.getMap(),
      );
    }
    return false;
  }

  Future<String?> getImage(String url) async {
    Map<String, dynamic> jsonImage =
        await _fileManager.readItem(key: url) ?? {};
    if (jsonImage.isNotEmpty) {
      CacheImageModel model = CacheImageModel.fromJson(jsonImage);
      if (model.expiredDate.isAfter(DateTime.now())) {
        return model.encodedImage;
      } else {
        await _fileManager.removeItem(key: url);
      }
    }
    return null;
  }
}
