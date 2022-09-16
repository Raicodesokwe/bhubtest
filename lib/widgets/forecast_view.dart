import 'package:bhubtest/widgets/weather_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class ForecastView extends StatelessWidget {
  const ForecastView({
    Key? key,
    required this.size,
    required this.temp,
    required this.weather,
    required this.mintemp,
    required this.maxtemp,
    required this.now,
    required this.dayOneWeather,
    required this.dayoneTemp,
    required this.dayTwoWeather,
    required this.daytwoTemp,
    required this.dayThreeWeather,
    required this.daythreeTemp,
    required this.dayFourWeather,
    required this.dayfourTemp,
  }) : super(key: key);

  final Size size;
  final String temp;
  final String? weather;
  final String mintemp;
  final String maxtemp;
  final DateTime? now;
  final String? dayOneWeather;
  final String dayoneTemp;
  final String? dayTwoWeather;
  final String daytwoTemp;
  final String? dayThreeWeather;
  final String daythreeTemp;
  final String? dayFourWeather;
  final String dayfourTemp;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          SizedBox(
            height: size.height * 0.22,
          ),
          WeatherView(temp: temp, weather: weather, size: size),
          SizedBox(
            height: size.height * 0.13,
          ),
          Row(
            children: [
              Column(
                children: [
                  Text(
                    '$mintemp°',
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    'min',
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
              Spacer(),
              Column(
                children: [
                  Text(
                    '$temp°',
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    'Current',
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
              Spacer(),
              Column(
                children: [
                  Text(
                    '$maxtemp°',
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    'max',
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
            ],
          ),
          Divider(
            color: Colors.white,
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            children: [
              Text(
                '${DateFormat.E().format(now!.add(Duration(days: 1)))}',
                style: TextStyle(color: Colors.white),
              ),
              Spacer(),
              dayOneWeather == 'CLOUDS'
                  ? SvgPicture.asset(
                      'assets/images/cloudy.svg',
                      width: 25,
                      color: Colors.white,
                    )
                  : dayOneWeather == 'RAIN'
                      ? SvgPicture.asset(
                          'assets/images/rain.svg',
                          width: 25,
                          color: Colors.white,
                        )
                      : Container(),
              Spacer(),
              Text(
                '$dayoneTemp°',
                style: TextStyle(color: Colors.white),
              )
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            children: [
              Text(
                '${DateFormat.E().format(now!.add(Duration(days: 2)))}',
                style: TextStyle(color: Colors.white),
              ),
              Spacer(),
              dayTwoWeather == 'CLOUDS'
                  ? SvgPicture.asset(
                      'assets/images/cloudy.svg',
                      width: 25,
                      color: Colors.white,
                    )
                  : dayTwoWeather == 'RAIN'
                      ? SvgPicture.asset(
                          'assets/images/rain.svg',
                          width: 25,
                          color: Colors.white,
                        )
                      : Container(),
              Spacer(),
              Text(
                '$daytwoTemp°',
                style: TextStyle(color: Colors.white),
              )
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            children: [
              Text(
                '${DateFormat.E().format(now!.add(Duration(days: 3)))}',
                style: TextStyle(color: Colors.white),
              ),
              Spacer(),
              dayThreeWeather == 'CLOUDS'
                  ? SvgPicture.asset(
                      'assets/images/cloudy.svg',
                      width: 25,
                      color: Colors.white,
                    )
                  : dayThreeWeather == 'RAIN'
                      ? SvgPicture.asset(
                          'assets/images/rain.svg',
                          width: 25,
                          color: Colors.white,
                        )
                      : Container(),
              Spacer(),
              Text(
                '$daythreeTemp°',
                style: TextStyle(color: Colors.white),
              )
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            children: [
              Text(
                '${DateFormat.E().format(now!.add(Duration(days: 4)))}',
                style: TextStyle(color: Colors.white),
              ),
              Spacer(),
              dayFourWeather == 'CLOUDS'
                  ? SvgPicture.asset(
                      'assets/images/cloudy.svg',
                      width: 25,
                      color: Colors.white,
                    )
                  : dayFourWeather == 'RAIN'
                      ? SvgPicture.asset(
                          'assets/images/rain.svg',
                          width: 25,
                          color: Colors.white,
                        )
                      : Container(),
              Spacer(),
              Text(
                '$dayfourTemp°',
                style: TextStyle(color: Colors.white),
              )
            ],
          ),
        ],
      ),
    );
  }
}
