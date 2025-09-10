import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rain_round/const/images.dart';
import 'package:rain_round/screens/home/controller/home_controller.dart';
import 'package:rain_round/screens/sound_slider_tile/view/sound_slider_tile.dart';
import 'package:rain_round/service/audio_service_controller.dart';
import '../../../controller/sharecontroller.dart';

class HomeScreen extends StatefulWidget {
  final bool afterChange;

  const HomeScreen({super.key, required this.afterChange});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var sharedController = Get.find<SharedController>();
  var homeController = Get.find<HomeController>();
  final AudioServiceController _audioService = AudioServiceController();

  double _masterVolume = 1.0;
  final Map<String, double> _volumes = {};

  late Future<bool> isLoaded;

  @override
  void initState() {
    super.initState();
    isLoaded = initializeApp();
  }


  Future<bool> initializeApp() async {
    try {
      // Initialize volumes with default values
      for (var sound in homeController.sounds) {
        _volumes[sound.id] = sound.defaultVolume;
      }
      await _audioService.initPlayers(homeController.sounds);
      widget.afterChange == true ? await _playAllSoundAfterChange() : null;
    } catch (e) {
      debugPrint('Error initializing app: $e');
    }
    return true;
  }

  Future<void> _playAllSoundAfterChange() async {
    if (homeController.isOn) {
      log('homeController.isOn in home: ${homeController.isOn}');
      await _audioService.playAll(_getEffectiveVolumes());
    } else {
      log('homeController.isOn in home else: ${homeController.isOn}');
      await _audioService.stopAll();
    }
  }

  Future<void> _toggleOn() async {
    setState(() {
      homeController.isOn = !homeController.isOn;
    });

    if (homeController.isOn) {
      log('homeController.isOn in home: ${homeController.isOn}');
      await _audioService.playAll(_getEffectiveVolumes());
    } else {
      log('homeController.isOn in home else: ${homeController.isOn}');
      await _audioService.stopAll();
    }
  }

  Future<void> _setVolume(String soundId, double volume) async {
    setState(() {
      _volumes[soundId] = volume;
    });

    if (homeController.isOn) {
      await _audioService.setVolume(soundId, _getEffectiveVolume(soundId));
    }
  }

  Future<void> _setMasterVolume(double volume) async {
    setState(() {
      _masterVolume = volume;
    });

    if (homeController.isOn) {
      for (var sound in homeController.sounds) {
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
    log('widget.afterChange: ${widget.afterChange}');
    return Scaffold(
      body: GetBuilder<HomeController>(
        id: 'home',
        builder: (controller) {
          log('getBuilder called');
          log('homeController.isOn: ${homeController.isOn}');
          return Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(bgImage),
                fit: BoxFit.cover,
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SafeArea(
                    child: Container(
                      margin: EdgeInsets.only(top: 20, left: 10),
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.white.withOpacity(0.3),
                            child: Icon(
                              Icons.cloudy_snowing,
                              color: Colors.white,
                            ),
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
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  ...[
                    Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 15,
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 6),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
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
                          ...homeController.sounds.map(
                            (sound) => Column(
                              children: [
                                SoundSliderTile(
                                  audioService: _audioService,
                                  isRain: sound.name.toLowerCase().contains(
                                    "rain",
                                  ),
                                  sound: sound,
                                  value: _volumes[sound.id] ?? 0.5,
                                  enabled: homeController.isOn,
                                  onChanged: (v) => _setVolume(sound.id, v),
                                ),
                                if (sound != homeController.sounds.last)
                                  Divider(
                                    color: Colors.white.withOpacity(0.2),
                                    // thickness: 1,
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
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
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24.0,
                          // vertical: 8,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: InkWell(
                                    onTap: _toggleOn,
                                    child: Container(
                                      padding: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.rectangle,
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                          color: Colors.white.withOpacity(0.3),
                                        ),
                                      ),
                                      child: Icon(
                                        Icons.power_settings_new_sharp,
                                        color:
                                            homeController.isOn
                                                ? Color(0xffd38677)
                                                : Colors.white,
                                        size: 35,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Global Controller",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontFamily:
                                            GoogleFonts.lato().fontFamily,
                                      ),
                                    ),
                                    Text(
                                      "Master Volume & Sound Controller",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontFamily:
                                            GoogleFonts.lato().fontFamily,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                SizedBox(width: 20),
                                const Icon(
                                  Icons.volume_up,
                                  color: Colors.white,
                                ),
                                Expanded(
                                  child: SliderTheme(
                                    data: SliderTheme.of(context).copyWith(
                                      trackHeight: 4,
                                      activeTrackColor: Color(0xffd38677),
                                      thumbColor: Colors.white,
                                    ),
                                    child: Slider(
                                      value: _masterVolume,
                                      onChanged: _setMasterVolume,
                                      min: 0.0,
                                      max: 1.0,
                                      //label: "Master: ${(_masterVolume * 100).toInt()}%",
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
