import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_weather/app.dart';
import 'package:flutter_weather/weather_bloc_observer.dart';
import 'package:weather_repository/weather_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  BlocOverrides.runZoned(
    () => runApp(WeatherApp(weatherRepository: WeatherRepository())),
    blocObserver: WeatherBlocObserver(),
  );
}
