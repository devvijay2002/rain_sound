import 'package:flutter/material.dart';
import 'package:rain_round/model/sound_model.dart';
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
  bool _isOn = false;
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
      
      // Initialize audio players
      await _audioService.initPlayers(kSounds);
      
      // If you want to load saved preferences here, you can do it
      // _loadPreferences();
      
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
      _volumes.entries.map(
        (e) => MapEntry(e.key, e.value * _masterVolume),
      ),
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
      appBar: AppBar(
        title: const Text('Rain Sound: Better Sleep'),
        backgroundColor: _isOn ? Colors.blueGrey.shade800 : Colors.blueGrey,
      ),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 96),
        children: [
          const SizedBox(height: 16),
          ...kSounds.map((sound) => SoundSliderTile(
                sound: sound,
                value: _volumes[sound.id] ?? 0.5,
                enabled: _isOn,
                onChanged: (v) => _setVolume(sound.id, v),
              )),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8),
            child: Row(
              children: [
                const Icon(Icons.volume_up),
                Expanded(
                  child: Slider(
                    value: _masterVolume,
                    onChanged: _setMasterVolume,
                    min: 0.0,
                    max: 1.0,
                    divisions: 20,
                    label: "Master: ${(_masterVolume * 100).toInt()}%",
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Text(
              "Sounds play in background & when screen is off. "
              "Your mix will be restored next time.",
              style: Theme.of(context).textTheme.bodySmall,
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 48.0),
            child: ElevatedButton(
              onPressed: _toggleOn,
              style: ElevatedButton.styleFrom(
                backgroundColor: _isOn ? Colors.red : Colors.green,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: Text(
                _isOn ? 'STOP' : 'START',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
