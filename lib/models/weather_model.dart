class WeatherModel {
  final DateTime date;
  final double temperature;
  final double tempMin;
  final double tempMax;
  final String iconCode;
  final String description;

  WeatherModel({
    required this.date,
    required this.temperature,
    required this.tempMin,
    required this.tempMax,
    required this.iconCode,
    required this.description,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      date: DateTime.parse(json["dt_txt"]),
      temperature: json["main"]["temp"],
      tempMin: json["main"]["temp_min"],
      tempMax: json["main"]["temp_max"],
      description: json["weather"][0]["description"],
      iconCode: json["weather"][0]["icon"],
    );
  }
}
