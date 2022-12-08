import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class CacheFileStorage {
  final String fileName = "agriaku_images_cache.json";

  static CacheFileStorage? _instance;
  CacheFileStorage._init();

  static CacheFileStorage get instance {
    CacheFileStorage? instance = _instance;
    if (instance == null) {
      return _instance = CacheFileStorage._init();
    } else {
      return instance;
    }
  }

  Future<Directory> _directoryBasePath() async {
    String tempPath = (await getTemporaryDirectory()).path;
    return Directory(tempPath).create();
  }

  Future<String> _filePath() async {
    final path = (await _directoryBasePath()).path;
    return "$path/$fileName";
  }

  Future<Map<String, dynamic>> _readFileContent() async {
    try {
      String filePath = await _filePath();
      File cacheFile = File(filePath);
      if (cacheFile.existsSync()) {
        final data = await cacheFile.readAsString();
        final jsonData = jsonDecode(data);

        return jsonData;
      }
    } catch (_) {
      rethrow;
    }
    return {};
  }

  Future writeItem({
    required String key,
    required Map<String, dynamic> content,
  }) async {
    String filePath = await _filePath();

    final Map<String, dynamic> oldData = await _readFileContent();
    oldData[key] = jsonEncode(content);

    File cacheFile = File(filePath);
    await cacheFile.writeAsString(
      jsonEncode(oldData),
      flush: true,
      mode: FileMode.write,
    );
  }

  Future<Map<String, dynamic>?> readItem({
    required String key,
  }) async {
    final Map<String, dynamic> images = await _readFileContent();
    String selectedItem = images[key] ?? '';
    if (selectedItem.isNotEmpty) {
      return jsonDecode(images[key]);
    }

    return null;
  }

  Future removeItem({required String key}) async {
    Map<String, dynamic> mapCache = await _readFileContent();
    if (mapCache[key] != null) {
      mapCache.remove(key);
      String filePath = await _filePath();
      File cacheFile = File(filePath);
      return await cacheFile.writeAsString(
        jsonEncode(mapCache),
        flush: true,
        mode: FileMode.write,
      );
    }
  }

  Future removeAll() async {
    String filePath = await _filePath();
    File cacheFile = File(filePath);
    if (cacheFile.existsSync()) {
      return cacheFile.delete();
    }
    return Future.value(null);
  }
}
