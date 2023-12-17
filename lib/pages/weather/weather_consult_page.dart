import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:weather/pages/weather/blocs/weather_consult_bloc.dart';

import '../../models/weather_model.dart';

class WeatherConsultPage extends StatefulWidget {
  const WeatherConsultPage({super.key});

  @override
  State<WeatherConsultPage> createState() => _WeatherConsultPageState();
}

class _WeatherConsultPageState extends State<WeatherConsultPage> {
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
      case 'dust':
      case 'fog':
      case 'rain':
        return 'assets/rain.json';
      case 'shower rain':
        return 'assets/rain.json';
      case 'drizzle':
      case 'thunderstorm':
        return 'assets/thunderstorm.json';
      case 'clear':
        return 'assets/sunny.json';
      default:
        return 'assets/sunny.json';
    }
  }

  late WeatherConsultBloc _weatherBloc;
  late Timer _timer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _weatherBloc = WeatherConsultBloc();
    _weatherBloc.add(const FetchWeather());

    // Configurar o timer para atualizar o clima a cada 1 minuto
    _timer = Timer.periodic(const Duration(minutes: 1), (Timer timer) {
      _weatherBloc.add(const FetchWeather());
    });
  }

  bool activeMoreInformation = false;
  Weather? _weather;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: BlocBuilder<WeatherConsultBloc, WeatherConsultState>(
        bloc: _weatherBloc,
        builder: (BuildContext context, state) {
          if (state is WeatherConsultLoading) {
            return Center(child: CircularProgressIndicator(color: Theme.of(context).primaryColor));
          } else if (state is WeatherConsultError) {
            return Center(
                child: Text(
              state.messageError,
              style: TextStyle(color: Theme.of(context).textTheme.bodySmall?.color),
            ));
          } else if (state is WeatherConsultSuccess) {
            _weather = state.weather;
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _weather?.cityName ?? 'loading city...',
                    style: TextStyle(color: Theme.of(context).textTheme.bodySmall?.color),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        activeMoreInformation = !activeMoreInformation;
                      });
                    },
                    child: Lottie.asset(getWeatherAnimations(_weather?.mainCondition)),
                  ),
                  Text(
                    _weather?.temperature.round().toString() != null
                        ? '${_weather?.temperature.toString()} °C'
                        : '...',
                    style: TextStyle(color: Theme.of(context).textTheme.bodySmall?.color),
                  ),
                  Text(
                    _weather?.mainCondition ?? '',
                    style: TextStyle(
                      color: Theme.of(context).textTheme.bodySmall?.color,
                    ),
                  ),
                  activeMoreInformation
                      ? Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Column(
                            children: [
                              Text(
                                _weather?.description != null
                                    ? 'description: ${_weather?.description}'
                                    : '',
                                style:
                                    TextStyle(color: Theme.of(context).textTheme.bodySmall?.color),
                              ),
                              Text(
                                _weather?.sensation.toString() != null
                                    ? 'sensation: ${_weather?.sensation.toString()} °C'
                                    : '',
                                style: TextStyle(
                                  color: Theme.of(context).textTheme.bodySmall?.color,
                                ),
                              ),
                              Text(
                                _weather?.humidity.toString() != null
                                    ? 'humidity: ${_weather?.humidity.toString()} %'
                                    : '',
                                style: TextStyle(
                                  color: Theme.of(context).textTheme.bodySmall?.color,
                                ),
                              ),
                              Text(
                                _weather?.wind.toString() != null
                                    ? 'wind: ${_weather?.wind.toString()}'
                                    : '',
                                style: TextStyle(
                                  color: Theme.of(context).textTheme.bodySmall?.color,
                                ),
                              ),
                            ],
                          ),
                        )
                      : const SizedBox(),
                ],
              ),
            );
          } else {
            return Center(
              child: Text(
                'Unknown state',
                style: TextStyle(color: Theme.of(context).textTheme.bodySmall?.color),
              ),
            );
          }
        },
      ),
    );
  }
}
