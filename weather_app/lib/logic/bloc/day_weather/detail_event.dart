import 'package:flutter/cupertino.dart';

abstract class WeatherDayEvent {
  const WeatherDayEvent();
}

class WeatherDayPageRequested extends WeatherDayEvent {
  final int index;
  WeatherDayPageRequested({@required this.index});
}

class WeatherDayDataRequested extends WeatherDayEvent {}
