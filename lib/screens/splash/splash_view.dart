import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../const/images.dart';
import '../../service/local_storage.dart';
import '../../service/sound_library.dart';
import '../home/controller/home_controller.dart';
import '../home/view/home_screen.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  var homeController = Get.find<HomeController>();

  @override
  void initState() {
    super.initState();
    initializeRoute();
  }

  Future<void> initializeRoute() async {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    homeController.sounds = await LocalStorage.getSounds();
    if (homeController.sounds.isEmpty) {
      homeController.sounds = kSounds;
    }
    await Future.delayed(const Duration(milliseconds: 500));
    if (!mounted) return;
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(splashBg),
          ),
        ),
      ),
    );
  }
}
