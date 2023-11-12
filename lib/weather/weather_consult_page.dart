import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather/services/weather_services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';


import '../models/weather_model.dart';

class WeatherConsultPage extends StatefulWidget {
  const WeatherConsultPage({super.key});

  @override
  State<WeatherConsultPage> createState() => _WeatherConsultPageState();
}

class _WeatherConsultPageState extends State<WeatherConsultPage> {
  //api_key
  final _weatherService = WeatherServices(dotenv.env['API_KEY']!);
  Weather? _weather;

  _fetchWeather() async {
    String cityName = await _weatherService.getCurrencyCity();

    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print(e);
    }
  }

  String getWeatherAnimations(String? mainCondition) {
    if (mainCondition == null) return 'assets/sunny.json';

    switch (mainCondition.toLowerCase()) {
      case 'clouds':
        return 'assets/clouds.json';
      case 'mist':
        return 'assets/mist.json';
      case 'smoke':
        return 'assets/smoke.json';
      case 'haze':
      // return 'assets/haze.json';
      case 'dust':
      // return 'assets/dust.json';
      case 'fog':
      // return 'assets/fog.json';
      case 'rain':
        return 'assets/rain.json';
      case 'shower rain':
        return 'assets/rain.json';
      case 'drizzle':
      // return 'assets/drizzle.dart';
      case 'thunderstorm':
        return 'assets/thunderstorm.json';
      case 'clear':
        return 'assets/sunny.json';
      default:
        return 'assets/sunny.json';
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _weather?.cityName ?? 'loading city...',
              style: TextStyle(color: Theme.of(context).textTheme.bodySmall?.color),
            ),
            Lottie.asset(getWeatherAnimations(_weather?.mainCondition)),
            Text(
              _weather?.temperature.round().toString() ?? '´°C',
              style: TextStyle(color: Theme.of(context).textTheme.bodySmall?.color),
            ),
            Text(
              _weather?.mainCondition ?? '',
              style: TextStyle(
                color: Theme.of(context).textTheme.bodySmall?.color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
