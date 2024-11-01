import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import 'package:weather_app_cubit/pages/weather_screen.dart';
import 'package:weather_app_cubit/services/api_servive.dart';
import 'package:weather_app_cubit/weather_cubit/weather_provider.dart';

void main() {
  runApp(
   BlocProvider(create: (context){
     return WeatherProvider(WeatherService());
   },
   child: MyApp(),)
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather Forecast',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WeatherScreen(),
    );
  }
}