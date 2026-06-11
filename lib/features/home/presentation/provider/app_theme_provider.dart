import 'package:flutter/material.dart';
import 'package:weather_app_task/features/home/data/data_sources/local/local_storage_service.dart';
import 'package:weather_app_task/general/utils/app_theme.dart';

class AppThemeProvider extends ChangeNotifier {
  final LocalStorageService localStorageService = LocalStorageService();

  ThemeData get appThemeData =>
      isThemeSelected ? AppTheme.darkMode : AppTheme.lightMode;

  bool isThemeSelected = false;

  AppThemeProvider() {
    loadAppTheme();
  }

  // Function for load app theme initially
  void loadAppTheme() {
    isThemeSelected = localStorageService.getAppThemeMode();

    notifyListeners();
  }

  // Functino for toggling app theme and saving it to hive local storage
  Future<void> toggleAppTheme() async {
    isThemeSelected = !isThemeSelected;

    await localStorageService.saveAppThemeMode(isThemeSelected);

    notifyListeners();
  }
}
