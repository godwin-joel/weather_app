import 'package:flutter/material.dart';
import 'package:weather_app/models/forecast_model.dart';

class ForecastWidget extends StatelessWidget {
   ForecastWidget({required this.forecastData, super.key});

  final List<ForecastModel> forecastData;
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Scrollbar(
        controller: scrollController,
        child: ListView.builder(
          padding: EdgeInsets.zero,
          controller: scrollController,
          itemCount: forecastData.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(top: index == 0 ? 0 : 8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(.05),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .05,
                        width: MediaQuery.of(context).size.height * .05,
                        child:
                            Image.asset('assets/${forecastData[index].icon}'),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        forecastData[index].text,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
