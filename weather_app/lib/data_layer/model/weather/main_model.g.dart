// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MainModel _$MainModelFromJson(Map<String, dynamic> json) {
  return MainModel(
    feels_like: (json['feels_like'] as num)?.toDouble(),
    grnd_level: json['grnd_level'] as int,
    humidity: json['humidity'] as int,
    pressure: json['pressure'] as int,
    sea_level: json['sea_level'] as int,
    temp: (json['temp'] as num)?.toDouble(),
    temp_kf: (json['temp_kf'] as num)?.toDouble(),
    temp_max: (json['temp_max'] as num)?.toDouble(),
    temp_min: (json['temp_min'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$MainModelToJson(MainModel instance) => <String, dynamic>{
      'temp': instance.temp,
      'feels_like': instance.feels_like,
      'temp_min': instance.temp_min,
      'temp_max': instance.temp_max,
      'pressure': instance.pressure,
      'sea_level': instance.sea_level,
      'grnd_level': instance.grnd_level,
      'humidity': instance.humidity,
      'temp_kf': instance.temp_kf,
    };
