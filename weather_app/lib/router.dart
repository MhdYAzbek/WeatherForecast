import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/data_layer/Repositories/app_repo.dart';
import 'package:weather_app/logic/bloc/wether/weather_bloc.dart';
import 'package:weather_app/logic/cubits/internet_cubit.dart';
import 'package:weather_app/presentation/weather_screen/components/weatherDetailsScreen.dart';
import 'package:weather_app/presentation/weather_screen/weatherScreen.dart';
import 'logic/bloc/day_weather/detail_bloc.dart';

//this class is responsible  for initialize route and app Bloc and repositories
class AppRouter {
  final AppRepository appRepository = AppRepository();

  Connectivity connectivity;
  WeatherBloc weatherBloc;
  WeatherDayBloc
      weatherDayBloc; // this bloc for reading from memory to get day weather
  AppRouter({@required this.connectivity}) {
    weatherBloc = new WeatherBloc(
      appRepository: appRepository,
      internetCubit: new InternetCubit(connectivity: connectivity),
    );
    weatherDayBloc = new WeatherDayBloc(appRepository: appRepository);
  }

  Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case WeatherScreen.routeName:
        return MaterialPageRoute(
            builder: (context) => MultiBlocProvider(
                  providers: [
                    BlocProvider.value(value: weatherBloc),
                  ],
                  child: WeatherScreen(),
                ));
        break;
      case DetailsPage.routeName:
        return MaterialPageRoute(
            builder: (context) => MultiBlocProvider(
                  providers: [
                    BlocProvider.value(value: weatherDayBloc),
                  ],
                  child: DetailsPage(),
                ));
        break;
      default:
        return null;
    }
  }

  void dispose() {
    weatherBloc.close();
    weatherDayBloc.close();
  }
}
