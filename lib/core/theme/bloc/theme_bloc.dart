import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_assessment/core/theme/appTheme/dark_theme.dart';
import 'package:flutter_assessment/core/theme/appTheme/light_theme.dart';
part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeState(themeData: lightMode)) {
    on<ToggleThemeEvent>((event, emit) {
      //if theme is lightmode
      if (state.themeData == lightMode) {
        //change the state to darkmode
        emit(ThemeState(themeData: darkMode));
      } else {
        emit(ThemeState(themeData: lightMode));
      }
    });
  }
}
