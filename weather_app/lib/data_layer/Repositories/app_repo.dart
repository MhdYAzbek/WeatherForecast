import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/data_layer/api/api_data_Provider.dart';
import 'package:weather_app/data_layer/model/weather/weatherApiResponse_model.dart';
import 'package:weather_app/presentation/weather_screen/components/dataset.dart';

class AppRepository {
  //define the key of memory data
  static const String key_temp = 'temp';
  static const String key_main = 'main';
  static const String key_time = 'time';
  // static const String key_icon = 'icon';
  static const String key_description = 'description';
  static const String key_wind = 'wind';
  static const String key_humidity = 'humidity';
  static const String key_city = 'city';
  static const String key_image = 'image';
  static final Duration timeout = Duration(seconds: 30);
  final WeatherApiDataProvider dataProvider = new WeatherApiDataProvider();
  Future<void> clear() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  // transform Json response to our weather Api response Model
  Future<WeatherApiResponse> getWeatherData({int cityId}) async {
    var response = await dataProvider.fetchWeatherJson(cityId: cityId);
    var jsonObj = json.decode(response.body);
    //print(jsonObj);
    var weatherApiModel = WeatherApiResponse.fromJson(jsonObj);
    //print("weatherApiModel");
    //print(weatherApiModel);
    return weatherApiModel;
  }

  //cached weather data to memory by index
  Future<void> persistWeather({List<DaysWeather> weatherList}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //print("persistWeather");
    for (int i = 0; i < weatherList.length; i++) {
      prefs.setDouble('$key_temp$i', weatherList[i].temp);
      prefs.setString('$key_main$i', weatherList[i].weatherMain);
      prefs.setString('$key_time$i', weatherList[i].time);
      //prefs.setString('$key_icon$i', weatherList[i].weatherIcon);
      prefs.setString('$key_description$i', weatherList[i].weatherDescription);
      //prefs.setString('$key_image$i', weatherList[i].image);
      prefs.setDouble('$key_wind$i', weatherList[i].windSpeed);
      prefs.setInt('$key_humidity$i', weatherList[i].humidity);
    }
    prefs.setString('$key_city', weatherList.first.city);
    return;
  }

  // get weather from app memory by day index [0 - 4]
  Future<DaysWeather> getWeather(String index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    DaysWeather weather = DaysWeather(
      temp: prefs.getDouble(key_temp + index),
      windSpeed: prefs.getDouble(key_wind + index),
      weatherMain: prefs.getString(key_main + index),
      //weatherIcon: prefs.getString(key_icon + index),
      weatherDescription: prefs.getString(key_description + index),
      humidity: prefs.getInt(key_humidity + index),
      time: prefs.getString(key_time + index),
      city: prefs.getString(key_city),
      //image: prefs.getString(key_image + index),
    );

    return weather;
  }
}
