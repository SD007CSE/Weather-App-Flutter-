part of 'weather_cubit.dart';

abstract class WeatherState extends Equatable {
  const WeatherState();
}

class WeatherInitial extends WeatherState {
  const WeatherInitial();

  @override
  List<Object?> get props => [];
}

class WeatherLoading extends WeatherState {
  const WeatherLoading();

  @override
  List<Object?> get props => [];
}

class WeatherSuccess extends WeatherState {
  final WeatherData weatherData;

  const WeatherSuccess({required this.weatherData});

  @override
  List<Object?> get props => [weatherData];
}

class WeatherError extends WeatherState {
  final String errorMessage;

  const WeatherError({this.errorMessage = 'Something Went Wrong'});

  @override
  List<Object?> get props => [errorMessage];
}
