import 'package:flutter/material.dart';
import 'package:flutter_assessment/app.dart';
import 'package:flutter_assessment/core/di/injector.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MultiBlocProvider(providers: getGlobalProviders(), child: App()));
}
