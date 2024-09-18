import 'dart:convert';

import 'package:http/http.dart' as http;

import '../constants.dart';
import '../models/weather_model.dart';

class WeatherApiClient {
  final String _baseUrl = 'https://api.weatherapi.com/v1/current.json';

  Future<WeatherModel?> fetchWeather(String location) async {
    final apiUrl = Uri.parse('$_baseUrl?key=$weatherApiKey&q=$location');
    
    try {
      final response = await http.get(apiUrl);

      if (response.statusCode == 200) {
        final Map<String, dynamic> json = jsonDecode(response.body);
        return WeatherModel.fromJson(json);
      } else {
        // to handle status codes except 200
        print('Failed to load weather data: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      // to handle exceptions
      print('Error fetching weather data: $e');
      return null;
    }
  }
}
