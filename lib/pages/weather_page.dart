import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_application/cubit/app_theme_cubit.dart';
import 'package:weather_application/cubit/weather_cubit.dart';
import 'package:lottie/lottie.dart';
import 'package:sliding_switch/sliding_switch.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  String? _city;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentPosition();
    if (_city == null) {
      getCurrentPosition();
    }
    Future.delayed(const Duration(seconds: 10), () {
      BlocProvider.of<WeatherCubit>(context).getWeather(_city);
    });
  }

  void getCurrentPosition() async {
    String city;
    city = await BlocProvider.of<WeatherCubit>(context).determinePosition();
    setState(() {
      _city = city;
      print(_city);
    });
  }

  @override
  Widget build(BuildContext context) {
    String weatherIcon(String? wCond) {
      String cond;
      print(wCond);

      switch (wCond) {
        case "Clouds":
          cond =
              "https://lottie.host/a107d2c1-2dad-4409-9791-bda9bda61407/LueI7kKyjO.json";
        case "Drizzle":
          cond =
              "https://lottie.host/63c59baa-51d5-4911-a255-af15921bfd33/XtcRVySs9y.json";
        case "Rain":
          cond =
              "https://lottie.host/07c1515f-0e23-4d11-a106-7496350b586a/ZwbqcX2j2K.json";
        case "Thunderstorm":
          cond =
              "https://lottie.host/5b6c228c-fda4-4811-ad53-cd3e844ab67f/860vltPMz6.json";
        case "Snow":
          cond =
              "https://lottie.host/1bdd6737-d507-4b08-bad5-38d7d378909b/wIdR9L2ETp.json";
        case "Mist" ||
              "Smoke" ||
              'Haze' ||
              'Dust' ||
              'Fog' ||
              'Sand' ||
              'Dust' ||
              'Ash' ||
              'Squall' ||
              'Tornado':
          cond =
              "https://lottie.host/9a35fee7-1b54-4059-a7d8-3facadbe6400/RYUC82x5iF.json";
        default:
          cond =
              "https://lottie.host/0143e2be-5eae-49d7-a466-c676400d955b/sGvncSgm46.json";
      }
      return cond;
    }

    return BlocBuilder<WeatherCubit, WeatherState>(
      builder: (context, state) {
        if (state is WeatherLoading || state is WeatherInitial) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (state is WeatherError) {
          return Scaffold(
            body: Center(
              child: Text(state.errorMessage),
            ),
          );
        } else if (state is WeatherSuccess) {
          return Scaffold(
            body: Center(
              child: Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).viewPadding.top + 50),
                  const Icon(
                    Icons.location_on,
                    size: 28,
                  ),
                  _city != null
                      ? InkWell(
                          onTap: () {
                            BlocProvider.of<AppThemeCubit>(context)
                                .setAppTheme();
                            debugPrint(BlocProvider.of<AppThemeCubit>(context)
                                .state
                                .brightness
                                .toString());
                          },
                          child: Text(
                            _city?.toUpperCase() ?? "Location not found",
                            style: GoogleFonts.kalam(
                              fontSize: 30,
                            ),
                          ),
                        )
                      : const CircularProgressIndicator(),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.16),
                  LottieBuilder.network(
                    height: 300,
                    width: 300,
                    fit: BoxFit.fill,
                    weatherIcon(state.weatherData.mainCondition),
                  ),
                  Text(
                    state.weatherData.mainCondition,
                    style: GoogleFonts.caveat(
                      fontSize: 28,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    '${state.weatherData.temparature.toStringAsFixed(0)}°C',
                    style: GoogleFonts.acme(
                      fontSize: 30,
                    ),
                  ),
                  SizedBox(
                      height: MediaQuery.of(context).viewPadding.bottom + 25)
                ],
              ),
            ),
          );
        }
        return const CircularProgressIndicator();
      },
    );
  }
}
