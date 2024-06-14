import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_apps/view/home/home_screen.dart';
import 'package:weather_apps/viewmodel/weather_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => WeatherProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Weather App',
        home: HomeScreen(),
      ),
    );
  }
}
