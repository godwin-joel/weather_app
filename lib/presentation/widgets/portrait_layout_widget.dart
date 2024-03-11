import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/bloc/weather_bloc.dart';
import 'package:weather_app/models/forecast_model.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/presentation/widgets/current_details_widget.dart';
import 'package:weather_app/presentation/widgets/current_weather_widget.dart';
import 'package:weather_app/presentation/widgets/forecast_widget.dart';

class PortraitLayout extends StatelessWidget {
  const PortraitLayout({
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
          padding: const EdgeInsets.all(16.0),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                SizedBox(
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
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .025,
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 12.0),
                  child: Row(
                    children: [Text('Forecast')],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .01,
                ),
                ForecastWidget(
                  forecastData: forecastData,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
