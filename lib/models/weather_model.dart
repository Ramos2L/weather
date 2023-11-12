class Weather {
  final String cityName;
  final double temperature;
  final String mainCondition;
  final String description;
  final double sensation;
  final double humidity;
  final double wind;

  Weather({
    required this.cityName,
    required this.temperature,
    required this.mainCondition,
    required this.description,
    required this.sensation,
    required this.humidity,
    required this.wind,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      cityName: json['name'],
      temperature: json['main']['temp'].toDouble(),
      mainCondition: json['weather'][0]['main'],
      description: json['weather'][0]['description'],
      sensation: json['main']['feels_like'].toDouble(),
      humidity: json['main']['humidity'].toDouble(),
      wind: json['wind']['speed'].toDouble(),
    );
  }
}
