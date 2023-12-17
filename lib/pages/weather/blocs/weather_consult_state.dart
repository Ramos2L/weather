
part of 'weather_consult_bloc.dart';

abstract class WeatherConsultState extends Equatable{
  const WeatherConsultState();

  @override
  List<Object?> get props => [];
}

class WeatherConsultInitial extends WeatherConsultState {
  const WeatherConsultInitial();
}

class WeatherConsultLoading extends WeatherConsultState {
  const WeatherConsultLoading();
}

class WeatherConsultError extends WeatherConsultState {
  final String messageError;
  const WeatherConsultError({required this.messageError});

  @override
  List<Object?> get props => [messageError];
}

class WeatherConsultSuccess extends WeatherConsultState {
  final Weather weather;
  const WeatherConsultSuccess({required this.weather});

  @override
  List<Object?> get props => [weather];
}
