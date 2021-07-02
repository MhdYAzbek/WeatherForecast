import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cloud_model.g.dart';

@JsonSerializable()
class CloudModel extends Equatable {
  final double all;

  CloudModel({this.all});

  factory CloudModel.fromJson(Map<String, dynamic> json) =>
      _$CloudModelFromJson(json);

  Map<String, dynamic> toJson() => _$CloudModelToJson(this);

  @override
  List<Object> get props => [all];
}
