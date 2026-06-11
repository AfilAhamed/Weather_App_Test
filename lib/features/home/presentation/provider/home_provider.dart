import 'package:flutter/material.dart';
import 'package:weather_app_task/features/home/data/data_sources/local/local_storage_service.dart';
import 'package:weather_app_task/features/home/data/model/weather_model.dart';
import 'package:weather_app_task/features/home/repo/home_repository_.dart';
import 'package:weather_app_task/general/service/internet_connectivity.dart';

class HomeProvider extends ChangeNotifier {
  final HomeRepository homeRepository = HomeRepository();

  final LocalStorageService localStorageService = LocalStorageService();

  WeatherModel? weatherModel;

  late String cityName;

  bool isLoading = true;

  bool isShowingCachedData = false;

  bool showRecentSearches = false;

  List<String> recentSearches = [];

  Future<void> searchByCityName({
    required String name,
    required Function(String) onError,
  }) async {
    cityName = name.trim();

    isLoading = true;
    notifyListeners();

    try {
      await getWeatherData(onError);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // Function for searching weather data by city name
  Future<void> getWeatherData(Function(String) onError) async {
    final hasInternet = await InternetConnectivityService.hasInternet();
    if (!hasInternet) {
      final cachedWeather = await localStorageService.getCachedWeatherData();

      if (cachedWeather != null) {
        weatherModel = cachedWeather.copyWith(isShowingCachedData: true);

        isShowingCachedData = true;

        notifyListeners();

        onError('No internet connection. Showing cached weather data.');
      } else {
        onError('No internet connection and no cached data available.');
      }

      return;
    }

    final result = await homeRepository.fetchWeatherData(cityName: cityName);

    result.fold(
      (errorMsg) {
        onError(errorMsg);
      },
      (success) async {
        weatherModel = success;

        isShowingCachedData = false;

        await localStorageService.saveWeatherData(success);

        await localStorageService.saveRecentSearch(
          success.cityName ?? cityName,
        );

        recentSearches = await localStorageService.getRecentSearches();

        notifyListeners();
      },
    );
  }

  // Function for fetching recent searches from hive local storage
  Future<void> loadRecentSearches() async {
    recentSearches = await localStorageService.getRecentSearches();

    notifyListeners();
  }

  // Function for toggling recent searches to handle UI
  void toggleRecentSearches({bool value = false}) {
    if (value) {
      showRecentSearches = false;
    } else {
      showRecentSearches = !showRecentSearches;
    }
    notifyListeners();
  }
}
