import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import '../../../model/sound_model.dart';

class HomeController extends GetxController {
  bool isOn = false;
  List<Sound> sounds = [];

  void updateHomePage() {
    update(['home']);

  }
}
