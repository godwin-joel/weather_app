import 'package:flutter/material.dart';
import 'package:weather_app/models/weather_model.dart';

class CurrentDetails extends StatelessWidget {
  CurrentDetails({required this.data, super.key});

  final WeatherModel data;
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.05),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Scrollbar(
          controller: scrollController,
          child: SingleChildScrollView(
            controller: scrollController,
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * .025,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Row(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .065,
                            width: MediaQuery.of(context).size.height * .065,
                            child: Image.asset('assets/temperature.png'),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            children: [
                              Text('${data.current.tempF}°F'),
                              Text('${data.current.tempC}°C'),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Row(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .065,
                            width: MediaQuery.of(context).size.height * .065,
                            child: Image.asset('assets/wind.png'),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('${data.current.windKph} km/h'),
                              Text('${data.current.windMph} m/h'),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .065,
                        width: MediaQuery.of(context).size.height * .065,
                        child: Image.asset('assets/humidity.png'),
                      ),
                      Text('${data.current.humidity}%'),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .065,
                        width: MediaQuery.of(context).size.height * .065,
                        child: Image.asset('assets/uv.png'),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text('${data.current.uv}%'),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .065,
                        width: MediaQuery.of(context).size.height * .065,
                        child: Image.asset('assets/rain.png'),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        children: [
                          Text(
                              '${data.forecast.forecastday[0].day.dailyChanceOfRain}%'),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
