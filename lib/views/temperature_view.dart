import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../models/weather_model.dart';

class TemperatureView extends StatelessWidget {
  final WeatherModel weatherData;

  const TemperatureView({super.key, required this.weatherData});

  @override
  Widget build(BuildContext context) {
    final locationName = weatherData.location?.name ?? 'Unknown location';
    final temperatureC = weatherData.current?.tempC ?? 0.0;
    final conditionText = weatherData.current?.condition?.text ?? 'No data';
    final conditionIcon = weatherData.current?.condition?.icon ?? '';
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CachedNetworkImage(
          imageUrl: 'https:$conditionIcon',
          placeholder: (context, url) => const CircularProgressIndicator(),
          errorWidget: (context, url, error) => const Icon(Icons.error),
          width: 180,
          height: 180,
          fit: BoxFit.cover,
        ),
        const SizedBox(height: 25),
        Text(
          conditionText,
          style: const TextStyle(
            fontSize: 30,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          '${temperatureC.toStringAsFixed(1)} °C',
          style: const TextStyle(
            fontSize: 48,
            fontWeight: FontWeight.bold,
            color: Colors.blueAccent,
          ),
        ),
        const SizedBox(height: 30),
        Text(
          locationName,
          style: const TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
