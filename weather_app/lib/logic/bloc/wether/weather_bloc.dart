import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/data_layer/Repositories/app_repo.dart';
import 'package:weather_app/data_layer/api/http_exception.dart';
import 'package:weather_app/logic/cubits/internet_cubit.dart';
import 'package:weather_app/logic/cubits/internet_state.dart';
import 'package:weather_app/presentation/weather_screen/components/dataset.dart';
import 'weather_event.dart';
import 'weather_state.dart';
import 'package:weather_app/data_layer/model/weather/weatherApiResponse_model.dart';

// the Bloc class that responsible for get data from API
class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final AppRepository appRepository;
  final InternetCubit internetCubit;

  StreamSubscription internetStreamSubscription;
  bool isConnected;
  WeatherApiResponse weatherApiResponse;
  List<DaysWeather> weatherBundles;
  List<DaysWeather> dayWeatherBundles;

  WeatherBloc({
    @required this.appRepository,
    @required this.internetCubit,
  })  : assert(appRepository != null && internetCubit != null),
        super(WeatherInitial()) {
    internetStreamSubscription = internetCubit.stream.listen((internetState) {
      if (internetState is InternetDisconnected) {
        isConnected = false;
      } else if (internetState is InternetConnected &&
          !(state is WeatherInitial)) {
        this.add(WeatherDataRequested());
        isConnected = true;
      } else if (internetState is InternetLoading) {}
    });
  }

  // IconData getIconData(WeatherApiResponse weatherApiResponse){
  //   switch(weatherApiResponse.){
  //     case '01d': return WeatherIcons.clear_day;
  //     case '01n': return WeatherIcons.clear_night;
  //     case '02d': return WeatherIcons.few_clouds_day;
  //     case '02n': return WeatherIcons.few_clouds_day;
  //     case '03d':
  //     case '04d':
  //       return WeatherIcons.clouds_day;
  //     case '03n':
  //     case '04n':
  //       return WeatherIcons.clear_night;
  //     case '09d': return WeatherIcons.shower_rain_day;
  //     case '09n': return WeatherIcons.shower_rain_night;
  //     case '10d': return WeatherIcons.rain_day;
  //     case '10n': return WeatherIcons.rain_night;
  //     case '11d': return WeatherIcons.thunder_storm_day;
  //     case '11n': return WeatherIcons.thunder_storm_night;
  //     case '13d': return WeatherIcons.snow_day;
  //     case '13n': return WeatherIcons.snow_night;
  //     case '50d': return WeatherIcons.mist_day;
  //     case '50n': return WeatherIcons.mist_night;
  //     default: return WeatherIcons.clear_day;
  //   }
  // }

  @override
  Stream<WeatherState> mapEventToState(WeatherEvent event) async* {
    if (event is WeatherPageRequested || event is WeatherDataRequested) {
      yield WeatherLoadInProgress();
      //print("WeatherLoadInProgress");
      try {
        // we can in Future remove cityId from here and make it dynamic throw
        //the event.cityId and pass it to event
        weatherApiResponse = await appRepository.getWeatherData(cityId: 292223);
        if (weatherApiResponse.cod == "200") {
          //get weather data from json response
          weatherBundles = buildWeatherList(weatherApiResponse);
          //build 5 days  data from weather data
          dayWeatherBundles = buildWeatherDays(weatherBundles);
          //save weather data to memory
          await appRepository.persistWeather(weatherList: dayWeatherBundles);
          yield WeatherLoadedSuccess(
              weatherData: weatherApiResponse,
              weatherBunbles: dayWeatherBundles,
              appRepository: appRepository);
          //print("WeatherLoadedSuccess");
        } else {
          yield WeatherLoadFailure(
              weatherStoredData: weatherApiResponse, message: "Invalid URL");
        }
      } catch (Exception) {
        if (Exception is HTTPException) {
          yield WeatherLoadFailure(
              weatherStoredData: weatherApiResponse,
              message: '${Exception.code} : ${Exception.message}');
        } else {
          yield WeatherLoadFailure(
              weatherStoredData: weatherApiResponse,
              message: "Some thing wrong");
        }
      }
    }
  }

// transform the WeatherAPIResponse to out weather list model
  List<DaysWeather> buildWeatherList(WeatherApiResponse weatherData) {
    return weatherData.list
        .map(
          (item) => DaysWeather(
              city: weatherData.city.name,
              country: weatherData.city.country,
              timeZone: weatherData.city.timezone,
              dTime: weatherData.list[weatherData.list.indexOf(item)].dt,
              time: weatherData.list[weatherData.list.indexOf(item)].dt_txt,
              humidity: weatherData
                  .list[weatherData.list.indexOf(item)].main.humidity,
              temp: weatherData.list[weatherData.list.indexOf(item)].main.temp,
              weatherDescription: weatherData
                  .list[weatherData.list.indexOf(item)]
                  .weather
                  .first
                  .description,
              weatherIcon: weatherData
                  .list[weatherData.list.indexOf(item)].weather.first.icon,
              weatherMain: weatherData
                  .list[weatherData.list.indexOf(item)].weather.first.main,
              windSpeed:
                  weatherData.list[weatherData.list.indexOf(item)].wind.speed),
        )
        .toList();
  }

  // Build our days List from all weather list model
  List<DaysWeather> buildWeatherDays(List<DaysWeather> dayWeatherBundles) {
    List<DaysWeather> dayWeather = [];
    dayWeather.add(dayWeatherBundles.first);
    int currentDay = DateTime.now().day;
    int secondDayIndex;
    //get the index of second day
    for (int i = 0; i < dayWeatherBundles.length - 1; i++) {
      int weatherDay =
          int.parse(dayWeatherBundles[i].time.split(" ").first.split("-")[2]);
      if (currentDay != weatherDay) {
        secondDayIndex = i;
        break;
      }
    }
    for (int i = secondDayIndex; i < dayWeatherBundles.length - 1; i += 8) {
      dayWeather.add(dayWeatherBundles[i]);
    }
    return dayWeather;
  }
}
