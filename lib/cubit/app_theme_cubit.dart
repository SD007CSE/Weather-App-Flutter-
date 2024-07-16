import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppThemeCubit extends Cubit<ThemeData> {
  AppThemeCubit() : super(ThemeData.dark());

  bool appTheme = false;

  Future<void> setAppTheme() async {
    emit(
      state.brightness == Brightness.light
          ? ThemeData.light()
          : ThemeData.dark(),
    );
  }
}
