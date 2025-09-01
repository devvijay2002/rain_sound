import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rain_round/const/images.dart';
import 'package:rain_round/screens/sound_slider_tile/view/sound_slider_tile.dart';
import 'package:rain_round/service/audio_service_controller.dart';
import 'package:rain_round/service/sound_library.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AudioServiceController _audioService = AudioServiceController();
  bool _isOn = true;
  double _masterVolume = 1.0;
  final Map<String, double> _volumes = {};

  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    try {
      // Initialize volumes with default values
      for (var sound in kSounds) {
        _volumes[sound.id] = sound.defaultVolume;
      }

      await _audioService.initPlayers(kSounds);
    } catch (e) {
      debugPrint('Error initializing app: $e');
    }
  }

  Future<void> _toggleOn() async {
    setState(() {
      _isOn = !_isOn;
    });

    if (_isOn) {
      await _audioService.playAll(_getEffectiveVolumes());
    } else {
      await _audioService.stopAll();
    }
  }

  Future<void> _setVolume(String soundId, double volume) async {
    setState(() {
      _volumes[soundId] = volume;
    });

    if (_isOn) {
      await _audioService.setVolume(soundId, _getEffectiveVolume(soundId));
    }
  }

  Future<void> _setMasterVolume(double volume) async {
    setState(() {
      _masterVolume = volume;
    });

    if (_isOn) {
      for (var sound in kSounds) {
        await _audioService.setVolume(sound.id, _getEffectiveVolume(sound.id));
      }
    }
  }

  double _getEffectiveVolume(String soundId) {
    return (_volumes[soundId] ?? 0.5) * _masterVolume;
  }

  Map<String, double> _getEffectiveVolumes() {
    return Map.fromEntries(
      _volumes.entries.map((e) => MapEntry(e.key, e.value * _masterVolume)),
    );
  }

  @override
  void dispose() {
    _audioService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage(bgImage), fit: BoxFit.cover),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.white.withOpacity(0.3),
                        child: Icon(Icons.cloudy_snowing, color: Colors.white),
                      ),
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Rain Sound",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontFamily:
                                  GoogleFonts.cinzelDecorative(
                                    fontWeight: FontWeight.w700,
                                  ).fontFamily,
                            ),
                          ),
                          Text(
                            'Relax & Sleep',
                            style: TextStyle(fontSize: 12, color: Colors.white),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  padding: EdgeInsets.symmetric(horizontal: 6),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.12),
                    // glassy effect
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.3),
                      width: 1.5,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      ...kSounds.map(
                        (sound) => Column(
                          children: [
                            SoundSliderTile(
                              sound: sound,
                              value: _volumes[sound.id] ?? 0.5,
                              enabled: _isOn,
                              onChanged: (v) => _setVolume(sound.id, v),
                            ),
                            if (sound != kSounds.last)
                              Divider(
                                color: Colors.white.withOpacity(0.3),
                                // thickness: 1,
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  /*Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24.0,
                    // vertical: 8,
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.volume_up, color: Colors.white),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 15,
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 6),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.12),
                            // glassy effect
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.3),
                              width: 1.5,
                            ),
                          ),

                          alignment: Alignment.center,
                          child: SliderTheme(
                            data: SliderTheme.of(context).copyWith(
                              trackHeight: 4,
                              activeTrackColor: Color(0xffd38677),
                              inactiveTrackColor: Colors.white,
                              thumbColor: Colors.white,
                              overlayColor: Colors.white.withOpacity(0.3),
                              valueIndicatorColor: Colors.white,
                              valueIndicatorTextStyle: const TextStyle(
                                color: Colors.black,
                                fontSize: 10,
                              ),
                              tickMarkShape: const RoundSliderTickMarkShape(),
                              activeTickMarkColor: Colors.white,
                              inactiveTickMarkColor: Colors.white,
                            ),
                            child: Slider(
                              value: _masterVolume,
                              onChanged: _setMasterVolume,
                              min: 0.0,
                              max: 1.0,
                              divisions: 10,
                              label: "Master: ${(_masterVolume * 100).toInt()}%",
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.only(bottom: 96),
                    children: [
                      ...kSounds.map(
                        (sound) => SoundSliderTile(
                          sound: sound,
                          value: _volumes[sound.id] ?? 0.5,
                          enabled: _isOn,
                          onChanged: (v) => _setVolume(sound.id, v),
                        ),
                      ),
                    ],
                  ),
                ),*/
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  padding: EdgeInsets.symmetric(horizontal: 6),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.12),
                    // glassy effect
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.3),
                      width: 1.5,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24.0,
                      // vertical: 8,
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.volume_up, color: Colors.white),
                        Expanded(
                          child: SliderTheme(
                            data: SliderTheme.of(context).copyWith(
                              trackHeight: 4,
                              activeTrackColor: Color(0xffd38677),
                              inactiveTrackColor: Colors.white,
                              thumbColor: Colors.white,
                              overlayColor: Colors.white.withOpacity(0.3),
                              valueIndicatorColor: Colors.white,
                              valueIndicatorTextStyle: const TextStyle(
                                color: Colors.black,
                                fontSize: 10,
                              ),
                              tickMarkShape: const RoundSliderTickMarkShape(),
                              activeTickMarkColor: Colors.white,
                              inactiveTickMarkColor: Colors.white,
                            ),
                            child: Slider(
                              value: _masterVolume,
                              onChanged: _setMasterVolume,
                              min: 0.0,
                              max: 1.0,
                              divisions: 10,
                              label: "Master: ${(_masterVolume * 100).toInt()}%",
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  /*Expanded(
                    child: ListView(
                      padding: const EdgeInsets.only(bottom: 96),
                      children: [
                        ...kSounds.map(
                              (sound) => SoundSliderTile(
                            sound: sound,
                            value: _volumes[sound.id] ?? 0.5,
                            enabled: _isOn,
                            onChanged: (v) => _setVolume(sound.id, v),
                          ),
                        ),
                      ],
                    ),
                  ),*/
                  /*Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24.0,
                    // vertical: 8,
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.volume_up, color: Colors.white),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 15,
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 6),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.12),
                            // glassy effect
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.3),
                              width: 1.5,
                            ),
                          ),

                          alignment: Alignment.center,
                          child: SliderTheme(
                            data: SliderTheme.of(context).copyWith(
                              trackHeight: 4,
                              activeTrackColor: Color(0xffd38677),
                              inactiveTrackColor: Colors.white,
                              thumbColor: Colors.white,
                              overlayColor: Colors.white.withOpacity(0.3),
                              valueIndicatorColor: Colors.white,
                              valueIndicatorTextStyle: const TextStyle(
                                color: Colors.black,
                                fontSize: 10,
                              ),
                              tickMarkShape: const RoundSliderTickMarkShape(),
                              activeTickMarkColor: Colors.white,
                              inactiveTickMarkColor: Colors.white,
                            ),
                            child: Slider(
                              value: _masterVolume,
                              onChanged: _setMasterVolume,
                              min: 0.0,
                              max: 1.0,
                              divisions: 10,
                              label: "Master: ${(_masterVolume * 100).toInt()}%",
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.only(bottom: 96),
                    children: [
                      ...kSounds.map(
                        (sound) => SoundSliderTile(
                          sound: sound,
                          value: _volumes[sound.id] ?? 0.5,
                          enabled: _isOn,
                          onChanged: (v) => _setVolume(sound.id, v),
                        ),
                      ),
                    ],
                  ),
                ),*/
                )
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _toggleOn,
        backgroundColor: Colors.black.withOpacity(0.5),
        child: Icon(
          Icons.power_settings_new_sharp,
          color: _isOn ? Color(0xffd38677) : Colors.white,
          size: 35,
        ),
      ),
    );
  }
}
