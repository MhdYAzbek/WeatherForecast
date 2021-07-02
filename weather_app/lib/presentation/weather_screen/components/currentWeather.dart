import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/logic/bloc/wether/weather.dart';
import 'package:weather_app/presentation/Configuration/size_config.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:flutter/cupertino.dart';
import 'extraWeather.dart';

// this class is responsible for Today Weather in the main screen
class CurrentWeather extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context); // to get the screen size
    return GlowContainer(
      height: SizeConfig.screenHeight / 1.5,
      margin: EdgeInsets.all(2),
      padding: EdgeInsets.only(top: 25, left: 30, right: 30),
      glowColor: Color(0xff00A1FF).withOpacity(0.5),
      borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(60), bottomRight: Radius.circular(60)),
      color: Color(0xff00A1FF),
      spreadRadius: 5,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Icon(CupertinoIcons.cloud_sun_rain_fill, color: Colors.white),
                  Text(
                    " Weather App",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                ],
              ),
            ],
          ),
          SingleChildScrollView(
            child: Container(
              height: SizeConfig.screenHeight / 3,
              child: Stack(
                children: [
                  // the image is static here (not relevant to data)
                  Image(
                    image: AssetImage("assets/images/sunny.png"),
                    fit: BoxFit.fill,
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    left: 0,
                    child: Center(
                      child: BlocBuilder<WeatherBloc, WeatherState>(
                          builder: (context, state) {
                        // if data is loaded Successfully from API
                        if (state is WeatherLoadedSuccess) {
                          return Column(
                            children: [
                              //weather temperature
                              GlowText(
                                state.weatherBunbles.first.temp.toString() +
                                    "\u00B0",
                                style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.redAccent),
                              ),
                              //Today weather City
                              Text(state.weatherBunbles.first.city,
                                  style: TextStyle(
                                    fontSize: 20,
                                  )),
                              Text(
                                  //today weather Time
                                  state.weatherBunbles.first.time
                                      .split(" ")
                                      .first,
                                  style: TextStyle(
                                    fontSize: 16,
                                  ))
                            ],
                          );
                          //if there is a problem when loading data
                        } else if (state is WeatherLoadInProgress) {
                          return Text(
                            "Loading Weather",
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          );
                        } else
                          return Text("");
                      }),
                    ),
                  )
                ],
              ),
            ),
          ),
          Divider(
            color: Colors.white,
          ),
          SizedBox(
            height: 10,
          ),
          // this widget is responsible for wind and humidity and weather state
          // it shows extra weather info
          // the index is needed here to refer to requested day
          ExtraWeather(
            index: 0,
          )
        ],
      ),
    );
  }
}
