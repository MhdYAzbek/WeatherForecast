import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:weather_app/data_layer/model/weather/main_model.dart';
import 'package:weather_app/data_layer/model/weather/weather_model.dart';
import 'package:weather_app/data_layer/model/weather/wind_model.dart';
import 'package:weather_app/data_layer/model/weather/cloud_model.dart';

part 'list_model.g.dart';

@JsonSerializable(explicitToJson: true)
class WeatherListModel extends Equatable {
  final int dt;
  final MainModel main;
  final List<WeatherModel> weather;
  final CloudModel clouds;
  final WindModel wind;
  final String dt_txt;

  WeatherListModel(
      {this.main, this.weather, this.clouds, this.dt, this.dt_txt, this.wind});

  factory WeatherListModel.fromJson(Map<String, dynamic> json) =>
      _$WeatherListModelFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherListModelToJson(this);

  @override
  List<Object> get props => [main, weather, clouds, dt, dt_txt, wind];
}
