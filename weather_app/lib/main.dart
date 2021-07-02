import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/data_layer/Repositories/app_repo.dart';
import 'package:weather_app/data_layer/api/api_data_Provider.dart';
import 'package:weather_app/presentation/Configuration/theme.dart';
import 'package:weather_app/presentation/weather_screen/weatherScreen.dart';
import 'package:weather_app/router.dart';

// //this class is responsible  for Bloc Observer
class SimpleBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object event) {
    super.onEvent(bloc, event);
    print(event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    print(error);
    super.onError(bloc, error, stackTrace);
  }
}

void main() {
  HttpOverrides.global =
      new MyHttpOverrides(); // to resolve problem of bad request unsecure http
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static Connectivity connectivity = Connectivity();
  AppRouter _appRouter = AppRouter(connectivity: connectivity);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider.value(value: _appRouter.weatherBloc),
          BlocProvider.value(value: _appRouter.weatherDayBloc),
        ],
        child: WeatherApp(
          appRepository: _appRouter.appRepository,
          appRouter: _appRouter,
        ));
  }
}

// the main  material App class
class WeatherApp extends StatefulWidget {
  final AppRepository appRepository;
  final AppRouter appRouter;
  const WeatherApp({
    Key key,
    this.appRouter,
    this.appRepository,
  }) : super(key: key);
  @override
  _WeatherAppState createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  @override
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AppRepository>(
          create: (context) => this.widget.appRepository,
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: this.widget.appRouter.onGenerateRoute,
        title: 'Weather App',
        theme: theme().copyWith(
            textTheme: Theme.of(context)
                .textTheme
                .apply(bodyColor: Colors.white, displayColor: Colors.blue)),
        home: WeatherScreen(),
      ),
    );
  }
}
