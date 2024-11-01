import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/weather_model.dart';

import 'weather_state.dart'; // Import your WeatherState definitions
import '../services/api_servive.dart';

class WeatherProvider extends Cubit<WeatherState> {
  final WeatherService weatherService;
  List<WeatherModel>? weatherList;

  WeatherProvider(this.weatherService) : super(InitialState());

  void getWeather({required String cityName}) async {
    emit(WeatherLoading());
    try {
      final data = await weatherService.getFiveDayWeather(cityName);
      weatherList = (data["list"] as List)
          .map((json) => WeatherModel.fromJson(json))
          .toList();
      emit(WeatherSuccess());
    } catch (e) {
      emit(WeatherFailure());
    }
  }
}