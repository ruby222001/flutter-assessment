import 'package:flutter/material.dart';
import 'package:flutter_assessment/core/theme/bloc/theme_bloc.dart';
import 'package:flutter_assessment/features/posts/page/dashboard.dart';
import 'package:flutter_assessment/features/posts/bloc/posts_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: themeState.themeData,
          title: 'Technical Assessment for ottr',
          home: Dashboard(),
        );
      },
    );
  }
}
