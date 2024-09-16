import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/services/preferences_service.dart';

import 'screens/help_screen.dart';
import 'screens/homepage_screen.dart';

Future<void> clearPreferences() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.clear();
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // await clearPreferences(); // for clearing preferences during testing
  bool tappedSkip = await preferencesService.getTappedSkip();
  // print("Has tapped skip: $tappedSkip"); // debugging log

  runApp(MyApp(tappedSkip: tappedSkip));
}

class MyApp extends StatelessWidget {
  final bool tappedSkip;

  const MyApp({super.key, required this.tappedSkip});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: tappedSkip ? const HomepageScreen() : const HelpScreen(),
    );
  }
}
