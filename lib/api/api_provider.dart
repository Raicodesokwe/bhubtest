import 'dart:convert';

import 'package:bhubtest/models/forecast_model.dart';
import 'package:bhubtest/models/weather_model.dart';
import 'package:dio/dio.dart';
import 'package:dio/native_imp.dart';
import 'package:flutter/material.dart';

class ApiProvider {
  String baseUrl = "https://api.openweathermap.org/data/2.5/";
  String appid = '1e0a239976f73a9fc7fcdee83d3fe361';
  Response? response;
  Dio dio = Dio();
  ApiProvider(this.dio) {
    dio = Dio();

    /// Dependency Injection
    dio.options.baseUrl;
  }

  //for api helper testing only
  ApiProvider.test(this.dio);

  Future<WeatherModel> getWeather({double? lat, double? lon}) async {
    final result = await dio.get(
        '${baseUrl}weather?lat=${lat.toString()}&lon=${lon.toString()}&appid=$appid');
    // print(result.data.toString());
    print(result.data['main'].toString());
    if (result.statusCode != 200) throw Exception();

    return WeatherModel.fromJson(result.data['main']);
  }

  Future<List<Weather>> getWeatherList({double? lat, double? lon}) async {
    List<Weather> weatherList = [];

    try {
      final result = await dio.get(
          '${baseUrl}weather?lat=${lat.toString()}&lon=${lon.toString()}&appid=$appid');
      final List weather = result.data['weather'];
      weatherList = weather.map((e) => Weather.fromJson(e)).toList();
      print(result.data.toString());
      if (result.statusCode != 200) throw Exception();
    } on DioError catch (e) {
      // TODO
      throw Exception();
    }

    return weatherList;
  }

  Future<List<ListElement>> getForecast({double? lat, double? lon}) async {
    List<ListElement> list = [];
    try {
      final result = await dio.get(
          '${baseUrl}forecast?lat=${lat.toString()}&lon=${lon.toString()}&appid=$appid');
      final List forecastlist = result.data['list'];
      print('Erick said ${forecastlist[0]}');
      list = forecastlist.map((e) => ListElement.fromJson(e)).toList();
      if (result.statusCode != 200) throw Exception();
    } on DioError catch (e) {
      throw Exception();
      // TODO
    }

    return list;
  }
}
