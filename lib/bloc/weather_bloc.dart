import 'package:bhubtest/bloc/base_bloc.dart';
import 'package:bhubtest/models/forecast_model.dart';
import 'package:bhubtest/models/weather_model.dart';
import 'package:rxdart/rxdart.dart';

class WeatherBloc extends BaseBloc {
  final getWeatherModelSubject = PublishSubject<WeatherModel>();
  Stream<WeatherModel> get getWeatherReportStream =>
      getWeatherModelSubject.stream;
  final getWeatherListModelSubject = PublishSubject<List<Weather>>();
  Stream<List<Weather>> get getWeatherListStream =>
      getWeatherListModelSubject.stream;
  final getForecastListModelSubject = PublishSubject<List<ListElement>>();
  Stream<List<ListElement>> get getForecastListStream =>
      getForecastListModelSubject.stream;
  @override
  void dispose() {
    // TODO: implement dispose
    getWeatherModelSubject.close();
    getWeatherListModelSubject.close();
    getForecastListModelSubject.close();
    super.dispose();
  }

  List<Weather> weatherList = [];
  List<ListElement> forecastList = [];
  Future getWeather(double lat, double lon) async {
    WeatherModel response = await repository.getWeather(lat: lat, lon: lon);
    getWeatherModelSubject.sink.add(response);
    return response;
  }

  Future getWeatherList(double lat, double lon) async {
    List<Weather> response =
        await repository.getWeatherList(lat: lat, lon: lon);

    weatherList = response;
    getWeatherListModelSubject.sink.add(response);
    return response;
  }

  Future getForecastList(double lat, double lon) async {
    List<ListElement> response =
        await repository.getForecastList(lat: lat, lon: lon);

    forecastList = response;
    getForecastListModelSubject.sink.add(response);
    return response;
  }
}
