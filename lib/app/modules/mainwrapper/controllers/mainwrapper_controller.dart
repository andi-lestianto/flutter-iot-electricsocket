import 'package:get/get.dart';
import 'package:smartsocket/app/routes/app_pages.dart';

class MainwrapperController extends GetxController {
  String currentRoutes = Routes.HOME;

  void updateCurrentRoutes(String route) async {
    if (route == '/') {
      currentRoutes = Routes.HOME;
    } else {
      currentRoutes = route;
    }
    await Future.delayed(Duration.zero).then((value) => update());
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
