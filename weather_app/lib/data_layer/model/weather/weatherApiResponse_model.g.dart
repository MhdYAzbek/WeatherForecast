// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weatherApiResponse_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherApiResponse _$WeatherApiResponseFromJson(Map<String, dynamic> json) {
  return WeatherApiResponse(
    message: json['message'] as int,
    city: json['city'] == null
        ? null
        : CityModel.fromJson(json['city'] as Map<String, dynamic>),
    cnt: json['cnt'] as int,
    cod: json['cod'] as String,
    list: (json['list'] as List)
        ?.map((e) => e == null
            ? null
            : WeatherListModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$WeatherApiResponseToJson(WeatherApiResponse instance) =>
    <String, dynamic>{
      'cod': instance.cod,
      'message': instance.message,
      'cnt': instance.cnt,
      'list': instance.list?.map((e) => e?.toJson())?.toList(),
      'city': instance.city?.toJson(),
    };
