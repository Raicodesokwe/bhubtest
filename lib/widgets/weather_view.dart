import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class WeatherView extends StatelessWidget {
  const WeatherView({
    Key? key,
    required this.temp,
    required this.weather,
    required this.size,
  }) : super(key: key);

  final String temp;
  final String? weather;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Row(
          children: [
            Spacer(),
            Column(
              children: [
                Text(
                  '$temp°',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 50,
                      color: Colors.white),
                ),
                Text(
                  weather!.toUpperCase(),
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                      color: Colors.white),
                ),
              ],
            ),
            Spacer(),
          ],
        ),
        Positioned(
          left: -30,
          top: -120,
          child: weather == 'Clouds'
              ? Align(
                  alignment: Alignment.topLeft,
                  child: SvgPicture.asset(
                    'assets/images/cloudy.svg',
                    width: size.width * 0.4,
                    color: Colors.white,
                  ),
                )
              : weather == 'Rain'
                  ? Align(
                      alignment: Alignment.topLeft,
                      child: SvgPicture.asset(
                        'assets/images/rain.svg',
                        width: size.width * 0.4,
                        color: Colors.white,
                      ),
                    )
                  : weather == 'Sun'
                      ? Align(
                          alignment: Alignment.topLeft,
                          child: SvgPicture.asset(
                            'assets/images/sun.svg',
                            width: size.width * 0.4,
                            color: Colors.white,
                          ),
                        )
                      : Container(),
        )
      ],
    );
  }
}
