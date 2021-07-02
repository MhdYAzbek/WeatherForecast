import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/logic/bloc/day_weather/detail.dart';
import 'package:weather_app/logic/bloc/wether/weather.dart';
import 'package:weather_app/presentation/Configuration/size_config.dart';
import 'package:weather_app/presentation/weather_screen/components/weatherDetailsScreen.dart';
import 'weatherWidget.dart';

//this is for weather Forecast section in main screen
class ForecastWeather extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context); // to get the screen size
    return Padding(
      padding: EdgeInsets.only(left: 30, right: 30, top: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Weather Forecast",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          buildContainer() // build list view of days forecast
        ],
      ),
    );
  }

  //build the list view
  Container buildContainer() {
    return Container(
      margin: EdgeInsets.only(
        bottom: 10,
      ),
      height: SizeConfig.screenHeight * 0.22,
      child: BlocBuilder<WeatherBloc, WeatherState>(builder: (context, state) {
        if (state is WeatherLoadedSuccess) {
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: state.weatherBunbles.length - 1,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return Row(
                //mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      context
                          .read<WeatherDayBloc>()
                          .add(WeatherDayPageRequested(index: index + 1));
                      Navigator.pushNamed(context, DetailsPage.routeName);
                    },
                    child: WeatherWidget(
                      state.weatherBunbles[
                          index + 1], // (index + 1)  to exclude the
                      // first day because we show first day in main screen
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                ],
              );
            },
          );
        } else
          return Center(child: Text("Loading"));
      }),
    );
  }
}
