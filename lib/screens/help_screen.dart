import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/services/preferences_service.dart';

import 'homepage_screen.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({super.key});

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  Timer? _timer;
  int _countdown = 5;

  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

  void _startCountdown() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_countdown > 0) {
          _countdown--;
        } else {
          _navigateToHomepage();
        }
      });
    });
  }

  void _navigateToHomepage() {
    _timer?.cancel();
    // print('Homepage navigating'); // debugging log

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomepageScreen()),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: CachedNetworkImage(
              imageUrl:
                  'https://www.vhv.rs/dpng/d/427-4270068_gold-retro-decorative-frame-png-free-download-transparent.png',
              placeholder: (context, url) => const Center(
                child: CircularProgressIndicator(),
              ),
              errorWidget: (context, url, error) => const Center(
                child: Icon(
                  Icons.error,
                ),
              ),
              fit: BoxFit.fill,
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'We show weather for you',
                  style: TextStyle(
                    fontSize: 27,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 280),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 10,
                    ),
                    backgroundColor: Colors.blueGrey,
                  ),
                  onPressed: () {
                    preferencesService.setTappedSkip();
                    // print('Skip button tapped'); // debugging log
                    _navigateToHomepage();
                  },
                  child: const Text(
                    'Skip',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Loading in $_countdown secs...',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.blueGrey,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
