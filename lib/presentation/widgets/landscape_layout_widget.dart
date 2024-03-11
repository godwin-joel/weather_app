import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/bloc/weather_bloc.dart';
import 'package:weather_app/models/forecast_model.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/presentation/widgets/current_details_widget.dart';
import 'package:weather_app/presentation/widgets/current_weather_widget.dart';
import 'package:weather_app/presentation/widgets/forecast_widget.dart';

class LandscapeLayout extends StatelessWidget {
  const LandscapeLayout({
    required this.data,
    required this.forecastData,
    super.key,
  });

  final WeatherModel data;
  final List<ForecastModel> forecastData;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherBloc, WeatherState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * .45,
                  child: Column(
                    children: [
                      const Row(
                        children: [
                          Text('Current weather'),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .02,
                      ),
                      CurrentWeather(
                        icon: data.current.condition.icon,
                        text: data.current.condition.text,
                        lastUpdated: data.current.lastUpdated,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .02,
                      ),
                      const Row(
                        children: [
                          Text('Current details'),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .02,
                      ),
                      CurrentDetails(
                        data: data,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * .05,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * .45,
                  child: Column(
                    children: [
                      const Row(
                        children: [Text('Forecast')],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .02,
                      ),
                      ForecastWidget(forecastData: forecastData),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
