// import 'package:alarm/alarm.dart';
import 'package:alarm/alarm.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:smartsocket/app/data/notification_model.dart';
import 'package:smartsocket/app/database/db_services.dart';
import 'package:smartsocket/app/modules/home/controllers/home_controller.dart';

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await Firebase.initializeApp();
  await initializeDateFormatting('id', null);
  await Alarm.init();
  await Alarm.ringStream.stream.listen((AlarmSettings event) {
    alarmAction(event);
  });

  runApp(MyApp());
  FlutterNativeSplash.remove();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 640),
      minTextAdapt: true,
      splitScreenMode: true,
      useInheritedMediaQuery: true,
      builder: (context, child) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Application",
        initialRoute: AppPages.INITIAL,
        getPages: AppPages.routes,
      ),
    );
  }
}

alarmAction(AlarmSettings event) async {
  print('trogger alarm');
  final DBServices dbServices = DBServices();
  List<NotificationAlarm> notificationAlarm =
      await dbServices.getAllNotificationData();

  if (notificationAlarm.isNotEmpty) {
    NotificationAlarm? currentAlarmData = notificationAlarm
        .firstWhereOrNull((element) => element.alarmSettings!.id == event.id);

    if (currentAlarmData != null) {
      print('Current Alarm Data');
      print(currentAlarmData.toJson());
      if (currentAlarmData.controlSocket != ControlSocket.none) {
        Get.lazyPut(() => HomeController(), fenix: true);
        final HomeController hc = Get.find();
        print(
            '${currentAlarmData.controlType} ${currentAlarmData.controlSocket}');
        hc.setSocketValueFromAlarm(
            controlSocket: currentAlarmData.controlSocket!,
            controlType: currentAlarmData.controlType!);
      }
    }
  }
}

//tes
