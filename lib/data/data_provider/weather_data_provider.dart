import 'package:http/http.dart' as http;
import 'package:weather_app/secrets.dart';

class WeatherDataProvider {
  Future<String> getCurrentWeather(String cityName) async {
    try {
      final res = await http.get(
        Uri.parse(
          'https://api.weatherapi.com/v1/forecast.json?key=$weatherAPIKey&q=$cityName&days=1&aqi=no&alerts=no',
        ),
      );
      if (res.statusCode == 200) {
        return res.body;
      } else {
        throw res.statusCode;
      }
    } catch (e) {
      throw e.toString();
    }
  }
}
