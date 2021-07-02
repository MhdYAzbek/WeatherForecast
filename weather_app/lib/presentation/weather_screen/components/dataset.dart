//the weather memory model
class DaysWeather {
  final int dTime;
  final String time;
  final double temp;
  final int humidity;
  final String weatherMain;
  final String weatherDescription;
  final String weatherIcon;
  final double windSpeed;
  final String city;
  final String country;
  final int timeZone;
  final String image;

  DaysWeather(
      {this.city,
      this.humidity,
      this.temp,
      this.country,
      this.image,
      this.weatherIcon,
      this.dTime,
      this.time,
      this.timeZone,
      this.weatherDescription,
      this.weatherMain,
      this.windSpeed});
}
