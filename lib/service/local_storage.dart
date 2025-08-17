import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static Future<void> saveIsOn(bool isOn) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isOn', isOn);
  }

  static Future<bool> loadIsOn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isOn') ?? false;
  }

  static Future<void> saveMasterVolume(double v) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('masterVolume', v);
  }

  static Future<double> loadMasterVolume() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble('masterVolume') ?? 1.0;
  }

  static Future<void> saveVolume(String soundId, double v) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('vol_$soundId', v);
  }

  static Future<double> loadVolume(String soundId, double defaultValue) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble('vol_$soundId') ?? defaultValue;
  }
}