import 'package:flutter/material.dart';
import 'dataset.dart';

//this is Container widget for weather 5 days forecast
class WeatherWidget extends StatelessWidget {
  final DaysWeather weather;
  WeatherWidget(this.weather);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.lightBlueAccent.withOpacity(0.5),
          border: Border.all(width: 0.2, color: Colors.white),
          borderRadius: BorderRadius.circular(35)),
      child: Column(
        children: [
          Text(
            weather.temp.toString() + "\u00B0",
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(
            height: 5,
          ),
          Image(
            // the image is static not relevant to data
            image: AssetImage("assets/images/rainy.png"),
            width: 25,
            height: 25,
          ),
          SizedBox(
            height: 2,
          ),
          Text(
            weather.weatherMain,
            style: TextStyle(fontSize: 14, color: Colors.white),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            weather.time.split(" ").first,
            style: TextStyle(fontSize: 14, color: Colors.white70),
          )
        ],
      ),
    );
  }
}
