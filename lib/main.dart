import 'package:flutter/material.dart';
import 'package:weather_app/services/preferences_service.dart';

import 'screens/help_screen.dart';
import 'screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // await clearPreferences(); // for clearing preferences during debugging
  bool tappedSkip = await preferencesService.getTappedSkip();
  // print("Has tapped skip: $tappedSkip"); // debugging log
  String? savedLocation = await preferencesService.getLocation();

  runApp(MyApp(tappedSkip: tappedSkip, savedLocation: savedLocation));
}

class MyApp extends StatelessWidget {
  final bool tappedSkip;
  final String? savedLocation;

  const MyApp({super.key, required this.tappedSkip, this.savedLocation});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: tappedSkip
          ? HomeScreen(savedLocation: savedLocation)
          : const HelpScreen(),
    );
  }
}
