import 'package:get/get.dart';

import '../controller/sharecontroller.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    // No need to initialize AudioController here as it's already initialized in main()
    // This binding is kept for future dependencies

    Get.put(SharedController(), permanent: true);
  }
}