import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class CacheImageStorage {
  // make this a singleton class
  CacheImageStorage._privateConstructor();
  static final CacheImageStorage instance =
      CacheImageStorage._privateConstructor();

  SharedPreferences? _preferences;
  final String preferenceImageKey = 'image_cache';

  Future<SharedPreferences> get sharedPreference async {
    SharedPreferences? preferences = _preferences;
    preferences ??= await SharedPreferences.getInstance();
    return preferences;
  }

  Future<bool> insertCache(String key, String value) async {
    final preference = await sharedPreference;

    Map<String, dynamic>? existingStorage = await _getCacheImages();
    if (existingStorage != null) {
      existingStorage[key] = value;

      return preference.setString(
        preferenceImageKey,
        jsonEncode(existingStorage),
      );
    }
    return false;
  }

  Future<String?> getCache(String key) async {
    Map<String, dynamic>? existingStorage = await _getCacheImages();
    if (existingStorage != null) {
      String? jsonImage = existingStorage[key];
      if (jsonImage != null) {
        return jsonImage;
      }
    }

    return null;
  }

  Future<Map<String, dynamic>?> _getCacheImages() async {
    final preference = await sharedPreference;

    /// get string of map image object from preferences
    String savedImages = preference.getString(preferenceImageKey) ?? '';

    if (savedImages.isEmpty) {
      return null;
    } else {
      return jsonDecode(savedImages);
    }
  }

  Future evictFromCache(String url) async {
    final preference = await sharedPreference;
    Map<String, dynamic>? existingStorage = await _getCacheImages();
    if (existingStorage != null) {
      existingStorage.remove(url);

      return preference.setString(
        preferenceImageKey,
        jsonEncode(existingStorage),
      );
    }
  }

  Future clearCache() async {
    final preference = await sharedPreference;
    preference.remove(preferenceImageKey);
  }
}
