import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:weather_app/logic/cubits/internet_state.dart';

class InternetCubit extends Cubit<InternetState> {
  final Connectivity connectivity;
  StreamSubscription connectivtiyStreamSubscription;

  InternetCubit({@required this.connectivity}) : super(InternetLoading()) {
    print("cubit initialized");

    connectivtiyStreamSubscription =
        connectivity.onConnectivityChanged.listen((connectivityResult) {
      if (connectivityResult == ConnectivityResult.wifi ||
          connectivityResult == ConnectivityResult.mobile) {
        emitInternetConnected();
      } else if (connectivityResult == ConnectivityResult.none) {
        emitInternetDisconnected();
      } else {
        print("Unknown Reason for Disconnection!!!");
        emitInternetDisconnected();
      }
    });
  }

  void emitInternetConnected() => emit(InternetConnected());

  void emitInternetDisconnected() => emit(InternetDisconnected());

  @override
  Future<void> close() {
    connectivtiyStreamSubscription.cancel();
    return super.close();
  }
}
