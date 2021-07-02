import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:weather_app/data_layer/model/weather/city_model.dart';
import 'package:weather_app/data_layer/model/weather/list_model.dart';

part 'weatherApiResponse_model.g.dart';

@JsonSerializable(explicitToJson: true)
class WeatherApiResponse extends Equatable {
  final String cod;
  final int message;
  final int cnt;
  final List<WeatherListModel> list;
  final CityModel city;

  WeatherApiResponse({this.message, this.city, this.cnt, this.cod, this.list});

  factory WeatherApiResponse.fromJson(Map<String, dynamic> json) =>
      _$WeatherApiResponseFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherApiResponseToJson(this);

  @override
  List<Object> get props => [message, city, cnt, cod, list];
}
