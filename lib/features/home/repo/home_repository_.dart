import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:weather_app_task/features/home/data/home_facade.dart';
import 'package:weather_app_task/features/home/data/model/weather_model.dart';
import 'package:weather_app_task/general/core/type_defs.dart';

class HomeRepository implements HomeFacade {
  final Dio _dio = Dio();


 // Function for fetching weather data from OpenWeather API
  @override
  FutureResult<WeatherModel> fetchWeatherData({
    required String cityName,
  }) async {
    try {
      String endpoint =
          "https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=3837f082b65893f0fc5883912ebd9ac8&units=metric";

      final response = await _dio.get(endpoint);

      if (response.statusCode == 200) {
        return right(WeatherModel.fromJson(response.data));
      }

      return left("Something went wrong. Please try again");
    } on DioException catch (e) {
      // no internet
      if (e.type == DioExceptionType.connectionError ||
          e.type == DioExceptionType.connectionTimeout) {
        return left("No internet connection. Showing cached data if available");
      }

      // invalid city
      if (e.response?.statusCode == 404) {
        return left("City not found. Please enter a valid city name");
      }

      // rate limit
      if (e.response?.statusCode == 429) {
        return left(
          "Too many requests. Please wait a few minutes and try again",
        );
      }

      // server error
      if ((e.response?.statusCode ?? 0) >= 500) {
        return left(
          "Weather service is currently unavailable. Please try again later",
        );
      }

      return left("Failed to fetch weather data");
    } catch (e) {
      return left("Unexpected error occurred");
    }
  }
}
