import 'package:bhubtest/api/api_provider.dart';
import 'package:bhubtest/models/weather_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

// class DioAdapterMock extends Mock implements HttpClientAdapter {}

void main() {
  final dio = Dio();
  final dioAdapter = DioAdapter(dio: dio);
  var baseUrl;
  var baseUrlTwo;
  final WeatherModel weatherModel = WeatherModel();
  setUp(() {
    dio.httpClientAdapter = dioAdapter;
    baseUrl = "https://api.openweathermap.org/data/2.5/";
  });
  group('ApiProvider class', () {
    test('Success case getweather', () async {
      dioAdapter.onGet(
        baseUrl,
        (request) => request.reply(200, {'message': 'Success!'}),
        data: Matchers.any,
        queryParameters: {},
        headers: {},
      );
      final service = ApiProvider(
        dio,
      );

      final response = await service.getWeather(lat: 1.09876, lon: 37.09876);

      expect(response, isA());
    });
    test('Success case getweatherlist', () async {
      dioAdapter.onGet(
        baseUrl,
        (request) => request.reply(200, {'message': 'Success!'}),
        data: Matchers.any,
        queryParameters: {},
        headers: {},
      );
      final service = ApiProvider(
        dio,
      );

      final response =
          await service.getWeatherList(lat: 1.09876, lon: 37.09876);

      expect(response, isA());
    });
    test('Success case getforecast', () async {
      dioAdapter.onGet(
        baseUrl,
        (request) => request.reply(200, {'message': 'Success!'}),
        data: Matchers.any,
        queryParameters: {},
        headers: {},
      );
      final service = ApiProvider(
        dio,
      );

      final response = await service.getForecast(lat: 1.09876, lon: 37.09876);

      expect(response, isA());
    });
    test('Failure case getforecast', () async {
      dioAdapter.onGet(
        baseUrl,
        (request) => request.throws(
            400,
            DioError(
                requestOptions: RequestOptions(
              path: baseUrl,
            ))),
        data: Matchers.any,
        queryParameters: {},
        headers: {},
      );
      final service = ApiProvider(
        dio,
      );

      final response = await service.getForecast(lat: 1.09876, lon: 37.09876);

      expect(response, isA());
    });
    test('Failure case getWeatherList', () async {
      dioAdapter.onGet(
        baseUrl,
        (request) => request.throws(
            400,
            DioError(
                requestOptions: RequestOptions(
              path: baseUrl,
            ))),
        data: Matchers.any,
        queryParameters: {},
        headers: {},
      );
      final service = ApiProvider(
        dio,
      );

      final response =
          await service.getWeatherList(lat: 1.09876, lon: 37.09876);

      expect(response, isA());
    });
    test('Failure case getWeather', () async {
      dioAdapter.onGet(
        baseUrl,
        (request) => request.throws(
            400,
            DioError(
                requestOptions: RequestOptions(
              path: baseUrl,
            ))),
        data: Matchers.any,
        queryParameters: {},
        headers: {},
      );
      final service = ApiProvider(
        dio,
      );

      final response = await service.getWeather(lat: 1.09876, lon: 37.09876);

      expect(response, isA());
    });
  });
}
