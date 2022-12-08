import 'package:custom_network_image/src/models/cache_image_sqflite_model.dart';
import 'package:custom_network_image/src/storage/sqflite_storage.dart';

class SqfliteService {
  final SqfliteStorage _sqfliteHelper = SqfliteStorage.instance;

  Future insertImage({
    required CacheImageSqfliteModel param,
  }) async {
    Map<String, dynamic> mapImage = param.getMap();

    if (mapImage.isNotEmpty) {
      return await _sqfliteHelper.insert(mapImage);
    }
    return false;
  }

  Future<String?> getSingleImage(String url) async {
    Map<String, dynamic>? jsonImage = await _sqfliteHelper.getSingleRow(url);
    if (jsonImage != null) {
      CacheImageSqfliteModel model = CacheImageSqfliteModel.fromJson(jsonImage);
      if (model.expiredAt.isAfter(DateTime.now())) {
        return model.encodedImage;
      } else {
        await _sqfliteHelper.remove(url);
      }
    }
    return null;
  }
}
