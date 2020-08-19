import 'dart:math';

import 'package:flutter/material.dart';
import 'package:weather_cubit/app/data/model/weather_model.dart';

abstract class WeatherRepository {
  Future<Weather> fetchWeather(String cityName);
}

class FakeWeatherRepository implements WeatherRepository {
  @override
  Future<Weather> fetchWeather(String cityName) {
    return Future.delayed(Duration(seconds: 2), () {
      final random = Random();
      //simulando erro de conexão
      if (random.nextBool()) {
        throw NetworkException();
      }
      return Weather(
          cityName: cityName,
          temperatureCelsius: 28 + random.nextInt(15) + random.nextDouble());
    });
    throw UnimplementedError();
  }
}

class NetworkException implements Exception {}
