import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:weather_app/logic/bloc/wether/weather.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/presentation/Configuration/size_config.dart';
import 'package:weather_app/presentation/weather_screen/components/currentWeather.dart';
import 'package:weather_app/presentation/weather_screen/components/forecastWeather.dart';

// the main screen that show Today Weather and wewather Forcast
class WeatherScreen extends StatefulWidget {
  static const routeName = "/weatherScreen";
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<WeatherBloc>().add(WeatherDataRequested());
  }

  RefreshController _refreshController =
      RefreshController(initialRefresh: false); // refresh page controller

  //this function is request data from API when pull screen to refresh
  void _onRefresh(BuildContext context) async {
    await Future.delayed(Duration(milliseconds: 1000)); // make some delays
    context.read<WeatherBloc>().add(WeatherPageRequested());
    _refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context); // to get the screen size
    return SmartRefresher(
      controller: _refreshController,
      onRefresh: () => _onRefresh(context),
      child: Scaffold(
        backgroundColor: Color(0xff030317),
        //check mobile orientation
        body: SizeConfig.orientation == Orientation.portrait
            ? SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Container(
                  child: Column(
                    //current weather  : is refer to today weather
                    // Forecast Weather is refer to 5 days brief weather
                    children: [CurrentWeather(), ForecastWeather()],
                  ),
                ),
              )
            // this Container applied when the phone is landscape
            : Container(
                child: Center(
                    child: Text(
                "Please Turn your phone",
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ))),
      ),
    );
  }
}
