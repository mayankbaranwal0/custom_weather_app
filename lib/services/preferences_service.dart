import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  static const String tappedSkipKey = 'tappedSkip';
  static const String locationKey = 'location';

  Future<void> clearPreferences() async { // method to clear preferences during debugging
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  Future<void> setTappedSkip() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(tappedSkipKey, true);
  }

  Future<bool> getTappedSkip() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(tappedSkipKey) ?? false;
  }

  Future<void> saveLocation(String location) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(locationKey, location);
  }

  Future<String?> getLocation() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(locationKey);
  }
}

final preferencesService = PreferencesService();
