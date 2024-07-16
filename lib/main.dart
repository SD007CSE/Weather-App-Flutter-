import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_application/cubit/app_theme_cubit.dart';
import 'package:weather_application/cubit/weather_cubit.dart';
import 'package:weather_application/pages/weather_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<WeatherCubit>(
          create: (context) => WeatherCubit(),
        ),
        BlocProvider<AppThemeCubit>(
          create: (context) => AppThemeCubit(),
        ),
      ],
      child: BlocBuilder<AppThemeCubit, ThemeData>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: const WeatherPage(),
          );
        },
      ),
    );
  }
}
