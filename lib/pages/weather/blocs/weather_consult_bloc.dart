import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../../models/weather_model.dart';
import '../../../services/weather_services.dart';

part 'weather_consult_event.dart';
part 'weather_consult_state.dart';

class WeatherConsultBloc extends Bloc<WeatherConsultEvent, WeatherConsultState> {
  //api_key
  final _weatherService = WeatherServices(dotenv.env['API_KEY']!);
  Weather? _weather;

  WeatherConsultBloc() : super(const WeatherConsultInitial()){
    on<FetchWeather>(_consultWeather);
  }

  void _consultWeather(FetchWeather event, Emitter<WeatherConsultState> emit) async {
    emit(const WeatherConsultLoading());

    String cityName = await _weatherService.getCurrencyCity();

    try {
      final weather = await _weatherService.getWeather(cityName);
      _weather = weather;
      emit(WeatherConsultSuccess(weather: weather));
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      emit(WeatherConsultError(messageError: e.toString()));
    }
  }
}