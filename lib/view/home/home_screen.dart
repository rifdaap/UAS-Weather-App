import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_apps/model/weather_model.dart';
import 'package:weather_apps/viewmodel/weather_provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<WeatherProvider>(context, listen: false).fetchWeather();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            'Weather App',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          titleSpacing: 10),
      backgroundColor: Color(0xFFE6DAC3),
      body: Center(
        child: Consumer<WeatherProvider>(
          builder: (ctx, weatherProvider, _) {
            if (weatherProvider.isLoading) {
              return CircularProgressIndicator();
            } else if (weatherProvider.errorMessage != null) {
              return Text('Error: ${weatherProvider.errorMessage}');
            } else if (weatherProvider.weather == null) {
              return Text('Failed to fetch weather data.');
            } else {
              final Weather weather = weatherProvider.weather!;
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Coordinates:',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('Latitude: ${weather.lat}'),
                  Text('Longitude: ${weather.lon}'),
                  Text('   '),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.network(
                          'https://openweathermap.org/img/wn/${weather.icon}@2x.png'),
                    ],
                  ),
                  Text('${weather.main}: ',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('${weather.description}'),
                  Text('   '),
                  Text('Temperature:',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('${weather.temp}°C'),
                  Text('   '),
                  Text('Feels Like: ',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('${weather.feelsLike}°C'),
                  Text('   '),
                  Text('Sunrise: ',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('${weather.formattedSunrise}'),
                  Text('   '),
                  Text('Sunset: ',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('${weather.formattedSunset}')
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
