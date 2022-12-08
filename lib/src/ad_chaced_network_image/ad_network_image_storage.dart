import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';

import 'ad_network_image_model.dart';

class ADNetworkImageStorage {
  /// This fileName will be used as the name of the cache file to be stored
  final String fileName = 'ad_network_images_cache.json';
  String temporaryDirectory = '';
  Map<String, dynamic> mapData = {};

  ADNetworkImageStorage() {
    removeExpiredImage();
  }

  /// get temporary directory
  Future<Directory> _directoryBasePath() async {
    if (temporaryDirectory.isEmpty) {
      temporaryDirectory = (await getTemporaryDirectory()).path;
    }
    return Directory(temporaryDirectory);
  }

  /// get path of cache file
  Future<String> _filePath() async {
    final basePath = (await _directoryBasePath()).path;
    return '$basePath/$fileName';
  }

  /// read content of cache file.
  /// content may empty, so this will returning empty map object as a default.
  Future<Map<String, dynamic>> _readFileContent() async {
    try {
      String filePath = await _filePath();
      File cacheFile = File(filePath);
      if (cacheFile.existsSync()) {
        final data = await cacheFile.readAsString();
        final jsonData = jsonDecode(data);
        mapData = jsonData;

        return jsonData;
      }
    } catch (_) {
      await removeAll();
    }
    return {};
  }

  /// write single string cache with unique key.
  Future writeItem({
    required String key,
    required Map<String, dynamic> content,
  }) async {
    String filePath = await _filePath();
    if (mapData.isEmpty) {
      mapData = await _readFileContent();
    }
    mapData[key] = jsonEncode(content);

    File cacheFile = File(filePath);
    await cacheFile.writeAsString(
      jsonEncode(mapData),
      flush: true,
      mode: FileMode.write,
    );
  }

  /// read single cache by key, this will returning map of object.
  /// the cache may not found, so this function will returning nullable value.
  Future<Map<String, dynamic>?> readItem({
    required String key,
  }) async {
    String selectedItem = mapData[key] ?? '';
    if (selectedItem.isNotEmpty) {
      return jsonDecode(mapData[key]);
    }

    return null;
  }

  /// removing single cache by key.
  Future removeItem({required String key}) async {
    if (mapData[key] != null) {
      mapData.remove(key);
      String filePath = await _filePath();
      File cacheFile = File(filePath);
      return await cacheFile.writeAsString(
        jsonEncode(mapData),
        flush: true,
        mode: FileMode.write,
      );
    }
  }

  /// removing expired images
  Future removeExpiredImage() async {
    debugPrint('-- execute removeExpiredImage --');
    mapData = await _readFileContent();

    if (mapData.isNotEmpty) {
      for (MapEntry<String, dynamic> item in mapData.entries) {
        try {
          ADNetworkImageModel model = ADNetworkImageModel.fromJson(
            jsonDecode(item.value),
          );

          if (DateTime.now().isAfter(model.expiredDate)) {
            await removeItem(key: item.key);
            mapData.remove(item.key);
          }
        } catch (_) {}
      }
    }
  }

  /// removing all caches
  Future removeAll() async {
    String filePath = await _filePath();
    File cacheFile = File(filePath);
    if (cacheFile.existsSync()) {
      return cacheFile.delete();
    }
  }
}
