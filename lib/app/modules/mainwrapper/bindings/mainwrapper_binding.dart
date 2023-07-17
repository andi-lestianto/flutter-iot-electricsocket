import 'package:get/get.dart';

import '../controllers/mainwrapper_controller.dart';

class MainwrapperBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainwrapperController>(
      () => MainwrapperController(),
    );
  }
}
