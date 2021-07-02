// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'city_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CityModel _$CityModelFromJson(Map<String, dynamic> json) {
  return CityModel(
    id: json['id'] as int,
    name: json['name'] as String,
    coord: json['coord'] == null
        ? null
        : CoordModel.fromJson(json['coord'] as Map<String, dynamic>),
    country: json['country'] as String,
    population: json['population'] as int,
    sunrise: json['sunrise'] as int,
    sunset: json['sunset'] as int,
    timezone: json['timezone'] as int,
  );
}

Map<String, dynamic> _$CityModelToJson(CityModel instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'coord': instance.coord?.toJson(),
      'country': instance.country,
      'population': instance.population,
      'timezone': instance.timezone,
      'sunrise': instance.sunrise,
      'sunset': instance.sunset,
    };
