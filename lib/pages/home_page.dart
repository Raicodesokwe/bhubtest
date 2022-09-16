import 'dart:async';

import 'package:bhubtest/bloc/weather_bloc.dart';
import 'package:bhubtest/models/forecast_model.dart';
import 'package:bhubtest/models/weather_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

import '../widgets/forecast_view.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  StreamSubscription? weatherReportSubscription;
  StreamSubscription? weatherListSubscription;
  StreamSubscription? forecastListSubscription;

  final WeatherBloc _bloc = WeatherBloc();
  DateTime? now = DateTime.now();
  String maxtemp = '';
  String dayoneTemp = '';
  String daytwoTemp = '';
  String daythreeTemp = '';
  String dayfourTemp = '';
  String dayfiveTemp = '';
  String mintemp = '';
  String? weather = '';
  String? dayOneWeather = '';
  String? dayTwoWeather = '';
  String? dayThreeWeather = '';
  String? dayFourWeather = '';
  String? dayFiveWeather = '';
  String temp = '';
  String? dateText = '';
  double? latitude;
  double? longitude;

  @override
  void initState() {
    _getCurrentLocation();

    super.initState();
  }

  void _getCurrentLocation() async {
    LocationPermission permission;
    bool serviceEnabled;
    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    if (serviceEnabled) {
      final LocationSettings locationSettings = LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 100,
      );
      var position =
          await Geolocator.getPositionStream(locationSettings: locationSettings)
              .listen((Position? position) {
        latitude = position!.latitude;
        longitude = position.longitude;
        _getWeather();
        _getWeatherList();
        _getForecast();
      });
    }
  }

  void _getWeather() {
    bool isLoaderNeeded = true;
    if (isLoaderNeeded) const CircularProgressIndicator();
    weatherListSubscription =
        _bloc.getWeatherListStream.listen((List<Weather> response) {
      weatherListSubscription?.cancel();

      weather = response[0].main;
      print('the list is ${response[0].main}');
    });
    _bloc.getWeatherList(latitude!, longitude!);
  }

  void _getForecast() {
    bool isLoaderNeeded = true;
    if (isLoaderNeeded) const CircularProgressIndicator();
    forecastListSubscription =
        _bloc.getForecastListStream.listen((List<ListElement> response) {
      forecastListSubscription?.cancel();
      dayoneTemp = response[10].main!.getTemp.round().toString();
      daytwoTemp = response[15].main!.getTemp.round().toString();
      daythreeTemp = response[20].main!.getTemp.round().toString();
      dayfourTemp = response[30].main!.getTemp.round().toString();
      dayOneWeather = response[10].weather![0].main.toString().split('.').last;
      dayTwoWeather = response[15].weather![0].main.toString().split('.').last;
      dayThreeWeather =
          response[20].weather![0].main.toString().split('.').last;
      dayFourWeather = response[30].weather![0].main.toString().split('.').last;
      print('masaa ni ${DateFormat.EEEE().format(response[30].dtTxt!)}');
      print(
          'hii ni ${response[3].weather![0].main.toString().split('.').last}');
      print('the temp is ${response[0].main!.getTemp.toString()}');
    });
    _bloc.getForecastList(latitude!, longitude!);
  }

  void _getWeatherList() {
    bool isLoaderNeeded = true;
    if (isLoaderNeeded) const CircularProgressIndicator();
    weatherReportSubscription =
        _bloc.getWeatherReportStream.listen((WeatherModel response) {
      weatherReportSubscription?.cancel();
      maxtemp = response.getMaxTemp.round().toString();
      mintemp = response.getMinTemp.round().toString();
      temp = response.getTemp.round().toString();
      print('the response is $response');
    });
    _bloc.getWeather(latitude!, longitude!);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('assets/images/sunnysea.png'))),
      child: StreamBuilder(
          stream: _bloc.getForecastListStream,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  'Something went wrong',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              );
            } else if (!snapshot.hasData ||
                snapshot.connectionState == ConnectionState.waiting) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Shimmer.fromColors(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Container(
                          width: double.infinity,
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(13),
                              color: Colors.orange.withOpacity(0.5)),
                        ),
                      ),
                      baseColor: Colors.orange.withOpacity(0.7),
                      highlightColor: Colors.orange.withOpacity(0.3)),
                  SizedBox(
                    height: 120,
                  ),
                  Shimmer.fromColors(
                      baseColor:
                          Color.fromARGB(255, 33, 47, 243).withOpacity(0.7),
                      highlightColor:
                          Color.fromARGB(255, 33, 47, 243).withOpacity(0.3),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [
                            Container(
                              width: double.infinity,
                              height: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(13),
                                  color: Color.fromARGB(255, 33, 47, 243)
                                      .withOpacity(0.5)),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Container(
                              width: double.infinity,
                              height: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(13),
                                  color: Color.fromARGB(255, 33, 47, 243)
                                      .withOpacity(0.5)),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Container(
                              width: double.infinity,
                              height: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(13),
                                  color: Color.fromARGB(255, 33, 47, 243)
                                      .withOpacity(0.5)),
                            ),
                          ],
                        ),
                      )),
                ],
              );
            }
            return ForecastView(
                size: size,
                temp: temp,
                weather: weather,
                mintemp: mintemp,
                maxtemp: maxtemp,
                now: now,
                dayOneWeather: dayOneWeather,
                dayoneTemp: dayoneTemp,
                dayTwoWeather: dayTwoWeather,
                daytwoTemp: daytwoTemp,
                dayThreeWeather: dayThreeWeather,
                daythreeTemp: daythreeTemp,
                dayFourWeather: dayFourWeather,
                dayfourTemp: dayfourTemp);
          }),
    ));
  }
}
