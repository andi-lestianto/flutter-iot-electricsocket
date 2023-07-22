import 'package:get/get.dart';

import 'package:smartsocket/app/modules/home/bindings/home_binding.dart';
import 'package:smartsocket/app/modules/home/views/home_view.dart';
import 'package:smartsocket/app/modules/mainwrapper/bindings/mainwrapper_binding.dart';
import 'package:smartsocket/app/modules/mainwrapper/views/mainwrapper_view.dart';
import 'package:smartsocket/app/modules/notification/bindings/notification_binding.dart';
import 'package:smartsocket/app/modules/notification/views/notification_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.MAINWRAPPER;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.MAINWRAPPER,
      page: () => MainwrapperView(),
      binding: MainwrapperBinding(),
    ),
    GetPage(
      name: _Paths.NOTIFICATION,
      page: () => NotificationView(),
      binding: NotificationBinding(),
    ),
  ];
}
