abstract class WeatherEvent {
  const WeatherEvent();
}

class WeatherPageRequested extends WeatherEvent {}

class WeatherDataRequested extends WeatherEvent {}
