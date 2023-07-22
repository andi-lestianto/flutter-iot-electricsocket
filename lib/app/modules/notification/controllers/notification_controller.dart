import 'package:alarm/alarm.dart';
import 'package:get/get.dart';
import 'package:smartsocket/app/data/notification_model.dart';
import 'package:smartsocket/app/helper/datetime_helper.dart';

class NotificationController extends GetxController {
  //TODO: Implement NotificationController

  List<NotificationAlarm> notificationAlarm = [];

  List<AlarmSettings> alarmSettting = [];

  addNotificationAlarm(
      {required DateTime timeAlarm, required String alarmName}) {
    notificationAlarm.add(NotificationAlarm(
        false,
        AlarmSettings(
          id: alarmSettting.isEmpty ? 1 : alarmSettting.last.id + 1,
          dateTime: DateTime.parse(
              '${DateTimeHelper().getDateNow()} ${timeAlarm.toString().split(' ').last}'),
          assetAudioPath: 'assets/audio/alarmtone.mp3',
          loopAudio: true,
          vibrate: true,
          fadeDuration: 3.0,
          notificationTitle: alarmName,
          notificationBody: 'Klik disini untuk menonaktifkan notifikasi',
          enableNotificationOnKill: true,
        )));
  }

  setAlarm({required AlarmSettings alarmSettings}) async {
    final response = await Alarm.set(alarmSettings: alarmSettings);
    if (response) {
      print('Alarm setted');
    } else {
      print('Alarm failed');
    }
  }

  getAlarm() async {
    final response = await Alarm.getAlarm(42);
    print(response?.notificationTitle);
    print('object');
  }

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    // setAlarm();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
