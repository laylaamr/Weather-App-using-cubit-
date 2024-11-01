import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weather_app_cubit/models/weather_model.dart';
import 'package:weather_app_cubit/weather_cubit/weather_state.dart';
import 'package:weather_app_cubit/weather_cubit/weather_provider.dart';

class WeatherScreen extends StatelessWidget {
  WeatherScreen({super.key});

  final TextEditingController _cityController = TextEditingController();

  String getDayOfWeek(DateTime dateTime) {
    return DateFormat('EEE').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blue,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _cityController,
                      decoration: const InputDecoration(
                        hintText: 'City Name',
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      final city = _cityController.text.trim();
                      if (city.isNotEmpty) {
                        context.read<WeatherProvider>().getWeather(cityName: city);
                      }
                    },
                    child: const Text('Search'),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Expanded(
                child: BlocBuilder<WeatherProvider, WeatherState>(
                  builder: (context, state) {
                    if (state is WeatherLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is WeatherSuccess) {
                      final weatherList = context.read<WeatherProvider>().weatherList!;
                      final currentWeather = weatherList[0]; // Get the first forecast item

                      return Column(
                        children: [
                          // Display current weather
                          Text(
                            "Current Temperature: ${currentWeather.temperature.toStringAsFixed(1)}°C",
                            style: const TextStyle(
                              fontSize: 24,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Description: ${currentWeather.description}",
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 20),
                          // Display the forecast list
                          Expanded(
                            child: ListView.builder(
                              itemCount: weatherList.length,
                              itemBuilder: (context, index) {
                                final forecast = weatherList[index];
                                String iconUrl = "https://openweathermap.org/img/wn/${forecast.iconCode}@2x.png";
                                return ListTile(
                                  leading: Image.network(iconUrl),
                                  title: Text(getDayOfWeek(forecast.date)),
                                  subtitle: Text(
                                    "Temp: ${forecast.temperature.toStringAsFixed(1)} °C\n${forecast.description}",
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      );
                    } else if (state is WeatherFailure) {
                      return const Center(
                        child: Text(
                          "Failed to load weather data. Please try again.",
                          style: TextStyle(color: Colors.red),
                        ),
                      );
                    }
                    return const Center(child: Text("Enter a city name to get forecast"));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


