// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:weather_app/data/data_provider/weather_data_provider.dart';
import 'package:weather_app/models/weather_model.dart';

class WeatherRepository {
  final WeatherDataProvider weatherDataProvider;
  WeatherRepository(this.weatherDataProvider);

  Future<WeatherModel> getCurrentWeather(String city) async {
    try {
      final response = await weatherDataProvider.getCurrentWeather(city);
      final data = jsonDecode(response);

      final weatherData = WeatherModel.fromJson(data);
      return weatherData;
    } catch (e) {
      throw e.toString();
    }
  }
}
