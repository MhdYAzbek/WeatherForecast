import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/logic/bloc/wether/weather.dart';
import 'dataset.dart';

//this class is for extra weather info in main screen
// humidity, wind speed , weather state
class ExtraWeather extends StatelessWidget {
  final int index;
  ExtraWeather({@required this.index});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          children: [
            Icon(
              CupertinoIcons.wind,
              color: Colors.white,
            ),
            SizedBox(
              height: 10,
            ),
            BlocBuilder<WeatherBloc, WeatherState>(
              builder: (context, state) {
                if (state is WeatherLoadedSuccess) {
                  return Text(
                    state.weatherBunbles[index].windSpeed.toString() + " Km/h",
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                  );
                } else
                  return Text("");
              },
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Wind",
              style: TextStyle(color: Colors.black54, fontSize: 16),
            )
          ],
        ),
        Column(
          children: [
            Icon(
              CupertinoIcons.wand_rays,
              color: Colors.white,
            ),
            SizedBox(
              height: 10,
            ),
            BlocBuilder<WeatherBloc, WeatherState>(
              builder: (context, state) {
                if (state is WeatherLoadedSuccess) {
                  return Text(
                    state.weatherBunbles[index].humidity.toString() + " %",
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                  );
                } else
                  return Text("");
              },
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Humidity",
              style: TextStyle(color: Colors.black54, fontSize: 16),
            )
          ],
        ),
        Column(
          children: [
            Icon(
              CupertinoIcons.cloud_sun_rain_fill,
              color: Colors.white,
            ),
            SizedBox(
              height: 10,
            ),
            BlocBuilder<WeatherBloc, WeatherState>(
              builder: (context, state) {
                if (state is WeatherLoadedSuccess) {
                  return Text(
                    state.weatherBunbles[index].weatherMain,
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                  );
                } else
                  return Text("");
              },
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "state",
              style: TextStyle(color: Colors.black54, fontSize: 16),
            )
          ],
        )
      ],
    );
  }
}
