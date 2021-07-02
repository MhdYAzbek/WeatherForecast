// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherListModel _$WeatherListModelFromJson(Map<String, dynamic> json) {
  return WeatherListModel(
    main: json['main'] == null
        ? null
        : MainModel.fromJson(json['main'] as Map<String, dynamic>),
    weather: (json['weather'] as List)
        ?.map((e) =>
            e == null ? null : WeatherModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    clouds: json['clouds'] == null
        ? null
        : CloudModel.fromJson(json['clouds'] as Map<String, dynamic>),
    dt: json['dt'] as int,
    dt_txt: json['dt_txt'] as String,
    wind: json['wind'] == null
        ? null
        : WindModel.fromJson(json['wind'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$WeatherListModelToJson(WeatherListModel instance) =>
    <String, dynamic>{
      'dt': instance.dt,
      'main': instance.main?.toJson(),
      'weather': instance.weather?.map((e) => e?.toJson())?.toList(),
      'clouds': instance.clouds?.toJson(),
      'wind': instance.wind?.toJson(),
      'dt_txt': instance.dt_txt,
    };
