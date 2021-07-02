import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:weather_app/data_layer/api/api_constants.dart';
import 'package:weather_app/data_layer/api/http_exception.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class WeatherApiDataProvider {
  static final Duration timeout = Duration(seconds: 30);
  static final String domain = API_BASE_URL;
  static final Map<String, String> headers = {};
  static final Map data = {};
  //static final String body = json.encode(data);
  Future<http.Response> getGeneric(int id) async {
    var url = domain + 'id=$id&appid=$API_KEY&units=metric';
    var response = await http.get(
      Uri.parse(url),
      headers: headers,
    );
    //print(response.body);
    if (response.statusCode != 200) {
      throw HTTPException(response.statusCode, "unable to fetch weather data");
    }
    return response;
  }

  Future<http.Response> fetchWeatherJson({int cityId}) async =>
      getGeneric(cityId);
}
