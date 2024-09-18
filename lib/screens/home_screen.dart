import 'package:flutter/material.dart';
import 'package:weather_app/views/temperature_view.dart';

import '../models/weather_model.dart';
import '../services/preferences_service.dart';
import '../services/weather_api_client.dart';
import 'help_screen.dart';

class HomeScreen extends StatefulWidget {
  final String? savedLocation;

  const HomeScreen({super.key, this.savedLocation});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _locationController = TextEditingController();
  String _buttonText = "Save";
  WeatherModel? _weatherData;
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    if (widget.savedLocation != null) {
      _locationController.text = widget.savedLocation!;
      _buttonText = "Update";
      _fetchWeatherData(widget.savedLocation!);
    }
  }

  Future<void> _fetchWeatherData(String location) async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });
    try {
      final weatherApiClient = WeatherApiClient();
      final data = await weatherApiClient.fetchWeather(location);
      setState(() {
        _weatherData = data;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Error fetching weather data';
      });
    }
  }

  Future<void> _saveLocation() async {
    FocusScope.of(context).unfocus();
    await preferencesService.saveLocation(_locationController.text);
    setState(() {
      _buttonText = "Update";
      _fetchWeatherData(_locationController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Padding(
            padding: EdgeInsets.only(top: 40),
            child: Text(
              'Weather',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          automaticallyImplyLeading: false,
          actions: [
            Padding(
              padding: const EdgeInsets.only(top: 40, right: 20),
              child: Tooltip(
                message: 'Help',
                child: IconButton(
                  icon: const Icon(
                    Icons.help_outline,
                    size: 28,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HelpScreen(),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
          toolbarHeight: 110,
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: SearchBar(
                        hintText: 'Enter Location',
                        controller: _locationController,
                        leading: const Padding(
                          padding: EdgeInsets.all(10),
                          child: Icon(Icons.location_on_outlined),
                        ),
                        onSubmitted: (value) {
                          _saveLocation();
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 22),
                SizedBox(
                  height: 45,
                  width: 130,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 10,
                      ),
                      backgroundColor: Colors.blueGrey,
                    ),
                    onPressed: _saveLocation,
                    child: Text(
                      _buttonText,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                if (_isLoading)
                  const CircularProgressIndicator()
                else if (_errorMessage != null)
                  Text(
                    _errorMessage!,
                    style: const TextStyle(color: Colors.red),
                  )
                else if (_weatherData != null)
                  TemperatureView(weatherData: _weatherData!)
                else if (widget.savedLocation != null)
                  Text(
                    'Weather data for ${widget.savedLocation}',
                    style: const TextStyle(fontSize: 20),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _locationController.dispose();
    super.dispose();
  }
}
