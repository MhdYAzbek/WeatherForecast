import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/data_layer/Repositories/app_repo.dart';
import 'package:weather_app/data_layer/model/weather/weatherApiResponse_model.dart';
import 'package:weather_app/presentation/weather_screen/components/dataset.dart';

abstract class WeatherDayState extends Equatable {
  const WeatherDayState();

  @override
  List<Object> get props => [];
}

class WeatherDayInitial extends WeatherDayState {}

class WeatherDayLoadInProgress extends WeatherDayState {}

class WeatherDayLoadedSuccess extends WeatherDayState {
  final DaysWeather weatherBundle;
  final AppRepository appRepository;
  const WeatherDayLoadedSuccess(
      {@required this.weatherBundle, @required this.appRepository})
      : assert(weatherBundle != null);

  @override
  List<Object> get props => [weatherBundle];
}

class WeatherDayLoadFailure extends WeatherDayState {
  final String message;
  WeatherDayLoadFailure({this.message});
}
