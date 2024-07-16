import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_application/model/weather_data.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit() : super(const WeatherInitial());

  //API CALL
  Future<void> getWeather(String? cityName) async {
    // URI
    try {
      print('Cubit:$cityName');
      String url =
          "http://api.openweathermap.org/data/2.5/weather?q=$cityName&units=metric&appid=cee0adbe78eb90e074257d47a2636868";

      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var data = WeatherData.fromMap(
            jsonDecode(response.body) as Map<String, dynamic>);
        emit(WeatherSuccess(weatherData: data));
      } else if (response.statusCode == 404) {
        emit(WeatherError(errorMessage: "Location can't accessible"));
      }
    } catch (e) {
      emit(WeatherError(errorMessage: e.toString()));
    }
  }

  Future<String> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    final loc = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    List<Placemark> placemark =
        await placemarkFromCoordinates(loc.latitude, loc.longitude);
    String? city = placemark[0].locality;
    return city ?? "Location can't be detected";
  }

  

}
