import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class HomeController extends GetxController{

  bool isOn = false;

  void updateHomePage(){
    update(['home']);
  }
}