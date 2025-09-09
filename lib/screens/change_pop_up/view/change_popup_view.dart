import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rain_round/model/sound_model.dart';
import 'package:rain_round/screens/home/controller/home_controller.dart';
import '../../../service/audio_service_controller.dart';
import '../../../service/local_storage.dart';
import '../../home/view/home_screen.dart';

class ChangePopupView extends StatefulWidget {
  final List<Sound> sounds;
  final AudioServiceController audioService;

  const ChangePopupView({
    super.key,
    required this.sounds,
    required this.audioService,
  });

  @override
  State<ChangePopupView> createState() => _ChangePopupViewState();
}

class _ChangePopupViewState extends State<ChangePopupView> {
  final Map<String, double> _volumes = {};
  final AudioServiceController _audioService = AudioServiceController();
  var homeController = Get.find<HomeController>();
  String playerId = "";

  Future<void> _toggleOn({required String playId}) async {

    homeController.isOn = false;
    await widget.audioService.stopAll();
    homeController.updateHomePage();
    log('homeController.isOn....: ${homeController.isOn}');
    if (playId == playerId) {
      playerId = '';
      setState(() {}); // update UI immediately
      await _audioService.stopOne(playId);
    } else {
      if (playerId.isNotEmpty) {
        await _audioService.stopOne(playerId);
      }
      playerId = playId;
      setState(() {}); // update UI immediately
      await _audioService.playOne(playId, 1);
    }
  }

  Future<void> setSound({required Sound newSound}) async {
    log('newSound: ${newSound.name}');
    var rainSoundIndex = homeController.sounds.indexWhere(
      (element) => element.name.toLowerCase().contains("rain"),
    );
    if (rainSoundIndex != -1) {
      homeController.sounds.removeAt(rainSoundIndex);
    }
    homeController.sounds.insert(0, newSound);
    await LocalStorage.saveSounds(sounds: homeController.sounds);
    homeController.isOn = true;
    // widget.audioService.playAll(volumes)
    homeController.updateHomePage();
  }

  Future<void> _initializeApp() async {
    try {
      // Initialize volumes with default values
      for (var sound in widget.sounds) {
        _volumes[sound.id] = sound.defaultVolume;
      }
      await _audioService.initPlayers(widget.sounds);
    } catch (e) {
      debugPrint('Error initializing app: $e');
    }
  }

  @override
  void initState() {
    _initializeApp();
    super.initState();
  }

  @override
  void dispose() {
    _audioService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    log('ChangePopupView Build called');
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(13),
          topRight: Radius.circular(13),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 22.0),
        child: Column(
          children: [
            Text(
              'Change Sound',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontFamily:
                    GoogleFonts.cinzelDecorative(
                      fontWeight: FontWeight.w700,
                    ).fontFamily,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: widget.sounds.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () async {
                      await setSound(newSound: widget.sounds[index]);
                      log('homecontroller isOn in chanagePop Up: ${homeController.isOn}');
                      Navigator.pop(context);
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                        return HomeScreen(
                          afterChange: true,
                        );
                      }));
                    },
                    child: Container(
                      // padding: const EdgeInsets.all(3.0),
                      margin: const EdgeInsets.symmetric(
                        vertical: 5.0,
                        horizontal: 10,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.white.withOpacity(0.5),
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: ListTile(
                        title: Text(
                          widget.sounds[index].name,
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily:
                                GoogleFonts.lato(
                                  fontWeight: FontWeight.w700,
                                ).fontFamily,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        trailing: GestureDetector(
                          onTap: () async {
                            await _toggleOn(playId: widget.sounds[index].id);
                          },
                          child:
                              widget.sounds[index].id == playerId
                                  ? Icon(
                                    Icons.pause_circle_outline,
                                    color: Colors.white,
                                    size: 30,
                                  )
                                  : Icon(
                                    Icons.play_circle_outlined,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
