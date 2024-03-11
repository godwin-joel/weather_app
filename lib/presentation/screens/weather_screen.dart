import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/bloc/weather_bloc.dart';
import 'package:weather_app/presentation/screens/weather_details_screen.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  static const List<String> majorCities = [
    'Chennai',
    'Mumbai',
    'Kolkata',
    'Pune',
    'Bengaluru',
    'Hyderabad',
    'Jaipur',
    'Indore',
    'Lucknow',
    'Kochi',
  ];
  TextEditingController searchTextController = TextEditingController();
  String selectedCity = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text(
          'Weather',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: BlocConsumer<WeatherBloc, WeatherState>(
        listener: (context, state) {
          if (state is WeatherSuccess) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => WeatherDetailsScreen(city: selectedCity),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is WeatherLoading) {
            return Center(
              child: Image.asset('assets/loader.gif'),
            );
          }
          if (state is WeatherFailure) {
            return Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * .2),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .25,
                    width: MediaQuery.of(context).size.height * .25,
                    child: Image.asset('assets/error.png'),
                  ),
                  const Text("We couldn't find any results!"),
                  const Text('Try again with a different city.'),
                  SizedBox(height: MediaQuery.of(context).size.height * .05),
                  IconButton(
                    onPressed: () {
                      context.read<WeatherBloc>().add(WeatherReset());
                    },
                    icon: const Icon(
                      Icons.refresh,
                      size: 40,
                    ),
                  ),
                ],
              ),
            );
          }
          return OrientationBuilder(
            builder: (context, orientation) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if ((orientation == Orientation.portrait))
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .3,
                        child: Center(
                          child: Image.asset('assets/weather_app_logo.gif'),
                        ),
                      ),
                    if (orientation == Orientation.portrait)
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .1,
                      ),
                    Autocomplete<String>(
                      fieldViewBuilder: (BuildContext context,
                          searchTextController,
                          FocusNode focusNode,
                          VoidCallback onFieldSubmitted) {
                        return Container(
                          width: MediaQuery.of(context).size.width * .9,
                          margin: EdgeInsets.only(
                              bottom:
                                  orientation == Orientation.portrait ? 10 : 0),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(.1),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(
                              top:
                                  orientation == Orientation.portrait ? 8.0 : 0,
                              bottom:
                                  orientation == Orientation.portrait ? 8.0 : 0,
                              left: 20,
                              right: 8,
                            ),
                            child: TextFormField(
                              cursorColor: Colors.white,
                              decoration: InputDecoration(
                                focusedBorder: InputBorder.none,
                                border: InputBorder.none,
                                hintText: 'City name',
                                hintStyle: TextStyle(
                                    color: Colors.white.withOpacity(.3)),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    if (searchTextController.text.isNotEmpty) {
                                      selectedCity = searchTextController.text
                                          .toUpperCase();
                                      context.read<WeatherBloc>().add(
                                          WeatherFetched(
                                              searchTextController.text));
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content:
                                              Text('Enter city name to search'),
                                        ),
                                      );
                                    }
                                  },
                                  icon: const Icon(
                                    Icons.search,
                                    color: Color(0xff006ee6),
                                  ),
                                ),
                              ),
                              controller: searchTextController,
                              focusNode: focusNode,
                            ),
                          ),
                        );
                      },
                      optionsBuilder: (TextEditingValue textEditingValue) {
                        if (textEditingValue.text == '') {
                          return const Iterable<String>.empty();
                        }
                        return majorCities.where((String option) {
                          return option
                              .toLowerCase()
                              .contains(textEditingValue.text.toLowerCase());
                        });
                      },
                      optionsViewBuilder: (context, onSelected, options) =>
                          Align(
                        alignment: Alignment.topLeft,
                        child: Material(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                                bottom: Radius.circular(4.0)),
                          ),
                          child: Container(
                              //   height: 52.0 * options.length,
                              width: MediaQuery.of(context).size.width * .9,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white.withOpacity(.1),
                              ),
                              child: ListView.separated(
                                itemBuilder: (cintext, index) {
                                  final String option =
                                      options.elementAt(index);
                                  return InkWell(
                                    onTap: () => onSelected(option),
                                    child: Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Text(option),
                                    ),
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return const Divider(
                                    indent: 20,
                                    endIndent: 20,
                                  );
                                },
                                itemCount: options.length,
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                              )),
                        ),
                      ),
                      onSelected: (String selection) {
                        selectedCity = selection.toUpperCase();
                        context
                            .read<WeatherBloc>()
                            .add(WeatherFetched(selection));
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),

      // body: BlocBuilder<WeatherBloc, WeatherState>(
      //   builder: (context, state) {
      //     // if (state is WeatherFailure) {
      //     //   return Center(
      //     //     child: Text(state.error),
      //     //   );
      //     // }

      //     // if (state is! WeatherSuccess) {
      //     //   return const Center(
      //     //     child: CircularProgressIndicator.adaptive(),
      //     //   );
      //     // }

      //     // if (state is WeatherInitial) {
      //     //   return
      //     // }

      // final data = state.weatherModel;
    );
  }
}
