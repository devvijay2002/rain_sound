import 'package:get/get.dart';
import 'package:rain_round/screens/home/controller/home_controller.dart';
import '../controller/sharecontroller.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    // No need to initialize AudioController here as it's already initialized in main()
    // This binding is kept for future dependencies


    Get.put(SharedController(), permanent: true);
    Get.lazyPut<HomeController>(() => HomeController(), fenix: true);
  }
}
