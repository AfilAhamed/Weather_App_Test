import 'package:weather_app_task/features/home/data/model/weather_model.dart';
import 'package:weather_app_task/general/core/type_defs.dart';

abstract class HomeFacade {

  FutureResult<WeatherModel> fetchWeatherData({required String cityName}) {
    throw UnimplementedError("fetchWeatherData() Not implemented");
  }
}
