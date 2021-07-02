import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'main_model.g.dart';

@JsonSerializable()
class MainModel extends Equatable {
  final double temp;
  final double feels_like;
  final double temp_min;
  final double temp_max;
  final int pressure;
  final int sea_level;
  final int grnd_level;
  final int humidity;
  final double temp_kf;

  MainModel(
      {this.feels_like,
      this.grnd_level,
      this.humidity,
      this.pressure,
      this.sea_level,
      this.temp,
      this.temp_kf,
      this.temp_max,
      this.temp_min});

  factory MainModel.fromJson(Map<String, dynamic> json) =>
      _$MainModelFromJson(json);

  Map<String, dynamic> toJson() => _$MainModelToJson(this);

  @override
  List<Object> get props => [temp, humidity, feels_like];
}
