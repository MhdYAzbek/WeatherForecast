import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/data_layer/Repositories/app_repo.dart';
import 'package:weather_app/presentation/weather_screen/components/dataset.dart';
import 'detail_event.dart';
import 'detail_state.dart';

// the Bloc class that responsible for get data from Memory using app repository
class WeatherDayBloc extends Bloc<WeatherDayEvent, WeatherDayState> {
  final AppRepository appRepository;

  DaysWeather weatherBundle;

  WeatherDayBloc({
    @required this.appRepository,
  })  : assert(appRepository != null),
        super(WeatherDayInitial());

  @override
  Stream<WeatherDayState> mapEventToState(WeatherDayEvent event) async* {
    if (event is WeatherDayPageRequested) {
      yield WeatherDayLoadInProgress();
      //print("WeatherLoadInProgress");
      try {
        //save weather data to memory
        weatherBundle = await appRepository.getWeather(event.index.toString());
        if (weatherBundle != null) {
          yield WeatherDayLoadedSuccess(
              weatherBundle: weatherBundle, appRepository: appRepository);
          // print("WeatherLoadedSuccess");
        } else {
          yield WeatherDayLoadFailure(message: " Loading wrong from memory");
        }
      } catch (Exception) {
        yield WeatherDayLoadFailure(message: " Loading Error");
      }
    }
  }
}
