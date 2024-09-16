import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  static const String tappedSkipKey = 'tappedSkip';

  Future<void> setTappedSkip() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(tappedSkipKey, true);
  }

  Future<bool> getTappedSkip() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(tappedSkipKey) ?? false;
  }
}

final preferencesService = PreferencesService();
