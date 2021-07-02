import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:weather_app/data_layer/model/weather/coord_model.dart';
part 'city_model.g.dart';

@JsonSerializable(explicitToJson: true)
class CityModel extends Equatable {
  final int id;
  final String name;
  final CoordModel coord;
  final String country;
  final int population;
  final int timezone;
  final int sunrise;
  final int sunset;

  CityModel(
      {this.id,
      this.name,
      this.coord,
      this.country,
      this.population,
      this.sunrise,
      this.sunset,
      this.timezone});

  factory CityModel.fromJson(Map<String, dynamic> json) =>
      _$CityModelFromJson(json);

  Map<String, dynamic> toJson() => _$CityModelToJson(this);

  @override
  List<Object> get props =>
      [timezone, sunset, sunrise, population, country, coord, name, id];
}
