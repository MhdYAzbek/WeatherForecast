import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'wind_model.g.dart';

@JsonSerializable()
class WindModel extends Equatable {
  final double speed;
  final double deg;
  final double gust;
  WindModel({this.speed, this.deg, this.gust});

  factory WindModel.fromJson(Map<String, dynamic> json) =>
      _$WindModelFromJson(json);

  Map<String, dynamic> toJson() => _$WindModelToJson(this);

  @override
  List<Object> get props => [speed];
}
