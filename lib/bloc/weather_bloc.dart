import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:weather_app/data/repository/weather_repository.dart';
import 'package:weather_app/models/forecast_model.dart';
import 'package:weather_app/models/weather_model.dart';
part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository weatherRepository;
  WeatherBloc(this.weatherRepository) : super(WeatherInitial()) {
    on<WeatherFetched>(_getCurrentWeather);
    on<WeatherReset>(_getWeatherForCity);
  }

  void _getCurrentWeather(
    WeatherFetched event,
    Emitter<WeatherState> emit,
  ) async {
    emit(WeatherLoading());
    try {
      final weather = await weatherRepository.getCurrentWeather(event.city);
      final List<ForecastModel> forecastData = [];
      forecastData.addAll(
        [
          ForecastModel(
            icon: 'sunrise.png',
            text: 'Sunrise ${weather.forecast.forecastday[0].astro.sunrise}',
          ),
          ForecastModel(
            icon: 'sunset.png',
            text: 'Sunset ${weather.forecast.forecastday[0].astro.sunset}',
          ),
          ForecastModel(
            icon: 'moonrise.png',
            text: 'Moonrise ${weather.forecast.forecastday[0].astro.moonrise}',
          ),
          ForecastModel(
            icon: 'moonset.png',
            text: 'Moonset ${weather.forecast.forecastday[0].astro.moonset}',
          ),
          ForecastModel(
            icon: 'temperature.png',
            text:
                'Max Temperature ${weather.forecast.forecastday[0].day.maxtempF}°F | ${weather.forecast.forecastday[0].day.maxtempC}°C',
          ),
          ForecastModel(
            icon: 'temperature.png',
            text:
                'Min Temperature ${weather.forecast.forecastday[0].day.mintempF}°F | ${weather.forecast.forecastday[0].day.mintempC}°C',
          ),
          ForecastModel(
            icon: 'wind.png',
            text:
                'Max wind speed ${weather.forecast.forecastday[0].day.maxwindKph} km/h | ${weather.forecast.forecastday[0].day.maxwindMph} m/h',
          ),
          ForecastModel(
            icon: 'humidity.png',
            text:
                'Avg humidity ${weather.forecast.forecastday[0].day.avghumidity} %',
          ),
          ForecastModel(
            icon: 'rain.png',
            text:
                'Chance of rain ${weather.forecast.forecastday[0].day.dailyChanceOfRain} %',
          ),
          ForecastModel(
            icon: 'uv.png',
            text: 'UV ${weather.forecast.forecastday[0].day.uv} mW/m2',
          ),
        ],
      );

      emit(WeatherSuccess(
        weatherModel: weather,
        forecastData: forecastData,
      ));
    } catch (e) {
      emit(WeatherFailure(e.toString()));
    }
  }

  void _getWeatherForCity(
    WeatherReset event,
    Emitter<WeatherState> emit,
  ) {
    emit(WeatherInitial());
  }
}
