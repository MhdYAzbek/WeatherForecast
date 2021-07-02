import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/data_layer/Repositories/app_repo.dart';
import 'package:weather_app/data_layer/model/weather/weatherApiResponse_model.dart';
import 'package:weather_app/presentation/weather_screen/components/dataset.dart';

abstract class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object> get props => [];
}

class WeatherInitial extends WeatherState {}

class WeatherLoadInProgress extends WeatherState {}

class WeatherLoadedSuccess extends WeatherState {
  final WeatherApiResponse weatherData;
  final List<DaysWeather> weatherBunbles;
  final AppRepository appRepository;
  const WeatherLoadedSuccess(
      {@required this.weatherData,
      @required this.weatherBunbles,
      @required this.appRepository})
      : assert(weatherData != null);

  @override
  List<Object> get props => [weatherData];
}

class WeatherLoadFailure extends WeatherState {
  final WeatherApiResponse weatherStoredData;
  final String message;
  WeatherLoadFailure({@required this.weatherStoredData, this.message});
}

class WeatherNoInternet extends WeatherState {}
