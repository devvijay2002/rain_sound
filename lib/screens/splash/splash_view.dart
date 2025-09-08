import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../const/images.dart';
import '../home/view/home_screen.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    initializeRoute();
  }

  Future<void> initializeRoute() async {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;
    Navigator.push(context,MaterialPageRoute(builder: (context)=>HomeScreen()));
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
