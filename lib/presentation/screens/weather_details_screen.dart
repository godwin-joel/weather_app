import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/bloc/weather_bloc.dart';
import 'package:weather_app/presentation/widgets/landscape_layout_widget.dart';
import 'package:weather_app/presentation/widgets/orientation_widget.dart';
import 'package:weather_app/presentation/widgets/portrait_layout_widget.dart';

class WeatherDetailsScreen extends StatelessWidget {
  const WeatherDetailsScreen({required this.city, super.key});
  final String city;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(city),
        centerTitle: true,
      ),
      body: BlocBuilder<WeatherBloc, WeatherState>(
        builder: (context, state) {
          if (state is! WeatherSuccess) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }

          final data = state.weatherModel;
          final forecastData = state.forecastData;

          return OrientationWidget(
            portraitWidget: PortraitLayout(
              data: data,
              forecastData: forecastData,
            ),
            landscapeWidget: LandscapeLayout(
              data: data,
              forecastData: forecastData,
            ),
          );
        },
      ),
    );
  }
}
