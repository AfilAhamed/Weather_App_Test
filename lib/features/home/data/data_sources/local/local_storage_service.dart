import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../model/weather_model.dart';

class LocalStorageService {
  static const String boxName = 'weather_box';
  Box get box => Hive.box(boxName);

  static const String lastWeatherDataKey = 'last_weather_data';
  static const String recentSearchesKey = 'recent_searches';
  static const String appThemeKey = 'is_dark_mode';

  Future<void> saveWeatherData(WeatherModel weather) async {
    await box.put(lastWeatherDataKey, weather.toMap());

    debugPrint('✅ Weather cached: ${weather.cityName}');
  }

  Future<WeatherModel?> getCachedWeatherData() async {
    final data = box.get(lastWeatherDataKey);

    if (data == null) {
      debugPrint('❌ No cached weather found');
      return null;
    }

    debugPrint('✅ Cached weather loaded: ${data['cityName']}');

    return WeatherModel.fromMap(Map<String, dynamic>.from(data));
  }

  Future<void> saveRecentSearch(String city) async {
    List<String> searches = List<String>.from(box.get(recentSearchesKey) ?? []);

    searches.remove(city);

    searches.insert(0, city);

    if (searches.length > 5) {
      searches = searches.take(5).toList();
    }

    await box.put(recentSearchesKey, searches);

    debugPrint('✅ Recent searches saved: $searches');
  }

  Future<List<String>> getRecentSearches() async {
    final searches = List<String>.from(box.get(recentSearchesKey) ?? []);

    debugPrint('📖 Recent searches loaded: $searches');

    return searches;
  }

  Future<void> saveAppThemeMode(bool isDarkMode) async {
    await box.put(appThemeKey, isDarkMode);

    debugPrint('🎨 Theme saved: $isDarkMode');
  }

  bool getAppThemeMode() {
    final isDarkMode = box.get(appThemeKey);

    debugPrint('🎨 Theme loaded: $isDarkMode');

    return isDarkMode ?? false;
  }
}
