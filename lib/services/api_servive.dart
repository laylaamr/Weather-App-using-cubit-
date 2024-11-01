import 'package:dio/dio.dart';

import '../models/weather_model.dart';

class WeatherService {
  final Dio _dio = Dio();
  final String apiKey = 'ae42a0ae8b4e866a8425d44f7a3f81b7';
  final String url = 'https://api.openweathermap.org/data/2.5/forecast';

  Future<Map<String, dynamic>> getFiveDayWeather(String city) async {
    try {
      final response = await _dio.get(
        url,
        queryParameters: {
          'q': city,
          'appid': apiKey,
          'units': 'metric',
        },
      );
      return response.data;
    } on DioError catch (e) {
      if (e.response != null) {
        return {"error": "This city not found, try again"};
      } else {
        return {"error": "Please check your connection"};
      }
    }
  }
}