import 'package:flutter/material.dart';

@immutable
abstract class InternetState {}

class InternetLoading extends InternetState {}

class InternetConnected extends InternetState {
  InternetConnected() : super();
}

class InternetDisconnected extends InternetState {}
