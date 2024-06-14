import 'package:intl/intl.dart';

class Weather {
  final double lon;
  final double lat;
  final String main;
  final String description;
  final String icon;
  final double temp;
  final double feelsLike;
  final int sunrise;
  final int sunset;

  Weather({
    required this.lon,
    required this.lat,
    required this.main,
    required this.description,
    required this.icon,
    required this.temp,
    required this.feelsLike,
    required this.sunrise,
    required this.sunset,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      lon: json['coord']['lon'].toDouble(),
      lat: json['coord']['lat'].toDouble(),
      main: json['weather'][0]['main'],
      description: json['weather'][0]['description'],
      icon: json['weather'][0]['icon'],
      temp: json['main']['temp'].toDouble(),
      feelsLike: json['main']['feels_like'].toDouble(),
      sunrise: json['sys']['sunrise'],
      sunset: json['sys']['sunset'],
    );
  }

  String get formattedSunrise {
    final date = DateTime.fromMillisecondsSinceEpoch(sunrise * 1000);
    return DateFormat('EEEE, d MMM yyyy HH:mm:ss').format(date);
  }

  String get formattedSunset {
    final date = DateTime.fromMillisecondsSinceEpoch(sunset * 1000);
    return DateFormat('EEEE, d MMM yyyy HH:mm:ss').format(date);
  }
}
