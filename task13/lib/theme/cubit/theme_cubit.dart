import 'package:flutter/material.dart';
import 'package:flutter_weather/weather/weather.dart';
import 'package:bloc/bloc.dart';

class ThemeCubit extends Cubit<Color> {
  ThemeCubit() : super(defaultColor);

  static const defaultColor = Color(0xFF2196F3);

  void updateTheme(Weather? weather) {
    if (weather != null) emit(weather.toColor);
  }
}

extension on Weather {
  Color get toColor {
    switch (condition) {
      case WeatherCondition.clear:
        return Colors.orangeAccent;
      case WeatherCondition.snowy:
        return Colors.lightBlueAccent;
      case WeatherCondition.cloudy:
        return Colors.blueGrey;
      case WeatherCondition.rainy:
        return Colors.indigoAccent;
      case WeatherCondition.unknown:
      default:
        return ThemeCubit.defaultColor;
    }
  }
}
