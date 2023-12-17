
part of 'weather_consult_bloc.dart';

abstract class WeatherConsultEvent extends Equatable {
  const WeatherConsultEvent();

  @override
  List<Object?> get props => [];
}

class FetchWeather extends WeatherConsultEvent {
  const FetchWeather();

  @override
  List<Object?> get props => [];
}