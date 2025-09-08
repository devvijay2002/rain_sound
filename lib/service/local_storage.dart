import 'dart:convert';

import 'package:rain_round/model/sound_model.dart';
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

  static Future<void> saveSounds({required List<Sound> sounds}) async {
    final prefs = await SharedPreferences.getInstance();
    var jsonString = json.encode(sounds.map((sound) => sound.toJson()).toList());
    await prefs.setString('sounds', jsonString);
  }

  static Future<List<Sound>> getSounds() async {
    try{
      final prefs = await SharedPreferences.getInstance();
      var jsonString = prefs.getString('sounds');
      if (jsonString == null) {
        return [];
      }
      return Sound.listFromJson(jsonString);
    }catch(e){
      return [];
    }
  }

}