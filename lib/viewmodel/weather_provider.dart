import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:weather_apps/model/weather_model.dart';

class WeatherProvider with ChangeNotifier {
  Weather? _weather;
  bool _isLoading = false;
  String? _errorMessage;

  Weather? get weather => _weather;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchWeather() async {
    final url = Uri.parse(
        'https://cors-anywhere.herokuapp.com/https://mgm.ub.ac.id/weather.json');
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final weatherData = json.decode(response.body);
        _weather = Weather.fromJson(weatherData);
      } else {
        _errorMessage = 'Failed to load weather data';
      }
    } catch (error) {
      _errorMessage = error.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
