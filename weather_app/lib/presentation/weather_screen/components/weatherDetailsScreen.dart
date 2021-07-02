import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:weather_app/logic/bloc/day_weather/detail.dart';
import 'package:weather_app/presentation/Configuration/size_config.dart';

/*
detail screen to show specific day forecast by reading from
memory using day index
this class is using weatherDayBloc to allocate data
*/
class DetailsPage extends StatelessWidget {
  static const routeName = "/detailScreen";
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context); // to get the screen size
    return Scaffold(
      backgroundColor: Color(0xff030317),
      body: SizeConfig.orientation == Orientation.portrait
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [WeatherByDay()],
            )
          : Container(
              child: Center(
                  child: Text(
              "Please Turn your phone",
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ))),
    );
  }
}

class WeatherByDay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: GlowContainer(
        color: Color(0xff00A1FF),
        glowColor: Color(0xff00A1FF),
        height: SizeConfig.screenHeight,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(100),
            topRight: Radius.circular(100),
            bottomLeft: Radius.circular(100),
            bottomRight: Radius.circular(100)),
        child: Column(
          children: [
            Padding(
              padding:
                  EdgeInsets.only(top: 50, right: 30, left: 30, bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      )),
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today,
                        color: Colors.white,
                      ),
                      Text(
                        " Weather Forecast",
                        style: TextStyle(
                            fontSize: SizeConfig.screenWidth / 15,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  Icon(Icons.more_vert, color: Colors.white)
                ],
              ),
            ),
            BlocBuilder<WeatherDayBloc, WeatherDayState>(
              builder: (context, state) {
                if (state is WeatherDayLoadedSuccess) {
                  return Text(
                    state.weatherBundle.time.split(" ").first,
                    style: TextStyle(fontSize: 24),
                  );
                } else
                  return Text("");
              },
            ),
            Padding(
              padding: EdgeInsets.all(2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: SizeConfig.screenWidth /
                        2, //MediaQuery.of(context).size.width / 2.3,
                    height: SizeConfig.screenWidth /
                        2, //MediaQuery.of(context).size.width / 2.3,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/images/sunny.png"))),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    // mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        height: SizeConfig.screenHeight * 0.3,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            BlocBuilder<WeatherDayBloc, WeatherDayState>(
                              builder: (context, state) {
                                if (state is WeatherDayLoadedSuccess) {
                                  return GlowText(
                                    state.weatherBundle.temp.toString() +
                                        "\u00B0",
                                    style: TextStyle(
                                        fontSize: SizeConfig.screenWidth / 8,
                                        fontWeight: FontWeight.bold),
                                  );
                                } else
                                  return Text("");
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      BlocBuilder<WeatherDayBloc, WeatherDayState>(
                        builder: (context, state) {
                          if (state is WeatherDayLoadedSuccess) {
                            return Text(
                              state.weatherBundle.weatherMain,
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold),
                            );
                          } else
                            return Text("");
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                bottom: 20,
                right: 50,
                left: 50,
              ),
              child: Column(
                children: [
                  Divider(color: Colors.white),
                  SizedBox(
                    height: 10,
                  ),
                  ExtraWeatherInfo(),
                  SizedBox(
                    height: 30,
                  ),
                  BlocBuilder<WeatherDayBloc, WeatherDayState>(
                    builder: (context, state) {
                      if (state is WeatherDayLoadedSuccess) {
                        return Text(
                          state.weatherBundle.weatherDescription,
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        );
                      } else
                        return Text("");
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// to show the extra weather info
class ExtraWeatherInfo extends StatelessWidget {
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
            BlocBuilder<WeatherDayBloc, WeatherDayState>(
              builder: (context, state) {
                if (state is WeatherDayLoadedSuccess) {
                  return Text(
                    state.weatherBundle.windSpeed.toString() + " Km/h",
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
            BlocBuilder<WeatherDayBloc, WeatherDayState>(
              builder: (context, state) {
                if (state is WeatherDayLoadedSuccess) {
                  return Text(
                    state.weatherBundle.humidity.toString() + " %",
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
            BlocBuilder<WeatherDayBloc, WeatherDayState>(
              builder: (context, state) {
                if (state is WeatherDayLoadedSuccess) {
                  return Text(
                    state.weatherBundle.weatherMain,
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
