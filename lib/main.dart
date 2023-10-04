import 'package:flutter/material.dart';
import 'package:movies_app_clean_architectures/core/services/service_locator.dart';
import 'package:movies_app_clean_architectures/core/utills/app_strings.dart';
import 'package:movies_app_clean_architectures/movies/presentation/pages/movies_screen.dart';

void main() {
  ServerLoc().setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppString.appName,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        textTheme: const TextTheme(),
        useMaterial3: true,
      ),
      home: const MoviesScreen(),
    );
  }
}
