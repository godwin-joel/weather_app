import 'package:flutter/material.dart';

class CurrentWeather extends StatelessWidget {
  const CurrentWeather(
      {required this.icon,
      required this.text,
      required this.lastUpdated,
      super.key});

  final String icon;
  final String text;
  final String lastUpdated;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.05),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Image.network("https:$icon"),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(text),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(lastUpdated),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
