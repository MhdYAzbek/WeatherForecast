import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'coord_model.g.dart';

@JsonSerializable()
class CoordModel extends Equatable {
  final double lat;
  final double lon;

  CoordModel({this.lat, this.lon});

  factory CoordModel.fromJson(Map<String, dynamic> json) =>
      _$CoordModelFromJson(json);

  Map<String, dynamic> toJson() => _$CoordModelToJson(this);

  @override
  List<Object> get props => [lat, lon];
}
